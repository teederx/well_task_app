import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:well_task_app/core/utils/constants/firebase_constants.dart';
import 'package:well_task_app/core/utils/config/local_notification_service.dart';

import '../../../../core/errors/failure.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_enums.dart';
import '../../../../domain/entities/subtask.dart';
import '../../../../domain/entities/time_log.dart';
import '../../../../domain/entities/attachment.dart';
import '../../../domain/repositories/tasks_repository.dart';
import '../../mappers/task_mapper.dart';
import '../../models/task_model/task_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final String userId;

  TasksRepositoryImpl({required this.userId});

  Future<Box> get _taskBox async {
    if (!Hive.isBoxOpen('Tasks_$userId')) {
      await Hive.openBox('Tasks_$userId');
    }
    return Hive.box('Tasks_$userId');
  }

  CollectionReference get _firestoreTasks {
    return usersCollection.doc(userId).collection('tasks');
  }

  final LocalNotificationService _notificationService =
      LocalNotificationService();

  Map<String, dynamic> _recursiveCast(Map<dynamic, dynamic> map) {
    return map.map((key, value) {
      final stringKey = key.toString();
      if (value is Map) {
        return MapEntry(stringKey, _recursiveCast(value));
      } else if (value is List) {
        return MapEntry(
          stringKey,
          value.map((e) => e is Map ? _recursiveCast(e) : e).toList(),
        );
      }
      return MapEntry(stringKey, value);
    });
  }

  @override
  Future<Either<Failure, void>> addTask({required Task task}) async {
    try {
      final taskModel = task.toModel();

      // 1. Save to Local Hive
      final box = await _taskBox;
      await box.put(task.id, taskModel.toJson());

      // 2. Sync to Firestore
      try {
        await _firestoreTasks.doc(task.id).set(taskModel.toJson());
      } catch (e) {
        debugPrint('Firestore sync failed: $e');
      }

      // 3. Schedule Notification
      if (task.alarmSet) {
        await _notificationService.ensureInitialized();
        await _notificationService.scheduleNotification(
          id: task.notificationId,
          title: task.title,
          body: task.description ?? 'Task Reminder',
          scheduledDate: task.dueDate,
        );

        if (task.remind5MinEarly) {
          await _notificationService.ensureInitialized();
          await _notificationService.scheduleNotification(
            id: task.notificationId + 100000,
            title: 'Upcoming: ${task.title}',
            body: '5 minutes until due',
            scheduledDate: task.dueDate.subtract(const Duration(minutes: 5)),
          );
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editTask({
    required String id,
    required String title,
    required String desc,
    required DateTime dueDate,
    required bool alarmSet,
    required bool remind5MinEarly,
    required TaskPriority priority,
    TaskCategory category = TaskCategory.other,
    List<String> tags = const [],
    RecurringType recurringType = RecurringType.none,
    int recurringInterval = 1,
    List<Subtask> subtasks = const [],
    int totalTimeSpent = 0,
    List<TimeLog> timeLogs = const [],
    DateTime? timerStartedAt,
    bool isTimerRunning = false,
    List<Attachment> attachments = const [],
  }) async {
    try {
      final box = await _taskBox;
      final taskMap = box.get(id);

      if (taskMap != null) {
        final taskMapCast = _recursiveCast(Map<dynamic, dynamic>.from(taskMap));
        final oldTaskModel = TaskModel.fromJson(taskMapCast);

        // Reconstruct the Task Entity with new values
        final newTaskEntity = Task(
          id: id,
          notificationId:
              oldTaskModel.notificationId, // Keep existing notificationId
          title: title,
          description: desc,
          dueDate: dueDate,
          isCompleted: oldTaskModel.isCompleted, // Not changed in editTask
          alarmSet: alarmSet,
          remind5MinEarly: remind5MinEarly,
          priority: priority,
          category: category,
          tags: tags,
          recurringType: recurringType,
          recurringInterval: recurringInterval,
          subtasks: subtasks,
          totalTimeSpent: totalTimeSpent,
          timeLogs: timeLogs,
          timerStartedAt: timerStartedAt,
          isTimerRunning: isTimerRunning,
          attachments: attachments,
        );

        final updatedTaskModel = newTaskEntity.toModel();
        final updatedJson = updatedTaskModel.toJson();

        // 1. Update Local
        await box.put(id, updatedJson);

        // 2. Update Firestore
        try {
          await _firestoreTasks.doc(id).update(updatedJson);
        } catch (e) {
          debugPrint('Firestore sync failed: $e');
        }

        // 3. Update Notifications
        await _notificationService.cancelNotification(
          oldTaskModel.notificationId,
        );
        await _notificationService.cancelNotification(
          oldTaskModel.notificationId + 100000,
        );

        if (alarmSet) {
          await _notificationService.ensureInitialized();
          await _notificationService.scheduleNotification(
            id: oldTaskModel.notificationId,
            title: title,
            body: desc.isEmpty ? 'Task Reminder' : desc,
            scheduledDate: dueDate,
          );

          if (remind5MinEarly) {
            await _notificationService.ensureInitialized();
            await _notificationService.scheduleNotification(
              id: oldTaskModel.notificationId + 100000,
              title: 'Upcoming: $title',
              body: '5 minutes until due',
              scheduledDate: dueDate.subtract(const Duration(minutes: 5)),
            );
          }
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final box = await _taskBox;

      // Trigger background sync
      _syncFromFirestore();

      final tasks = <Task>[];
      for (var e in box.values) {
        try {
          final castedMap = _recursiveCast(Map<dynamic, dynamic>.from(e));
          final model = TaskModel.fromJson(castedMap);
          tasks.add(model.toEntity());
        } catch (err) {
          debugPrint('⚠️ Error deserializing a task, skipping: $err');
        }
      }

      return Right(tasks);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _syncFromFirestore() async {
    try {
      final snapshot = await _firestoreTasks.get();
      final box = await _taskBox;

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        // Update local if remote is different (simplified sync)
        await box.put(doc.id, data);
      }
    } catch (e) {
      debugPrint('Sync from Firestore failed: $e');
    }
  }

  @override
  Future<Either<Failure, void>> removeTask({required String id}) async {
    try {
      final box = await _taskBox;
      final taskMap = box.get(id);
      if (taskMap != null) {
        final taskMapCast = _recursiveCast(Map<dynamic, dynamic>.from(taskMap));
        final task = TaskModel.fromJson(taskMapCast);
        await _notificationService.cancelNotification(task.notificationId);
        await _notificationService.cancelNotification(
          task.notificationId + 100000,
        );
      }

      await box.delete(id);

      try {
        await _firestoreTasks.doc(id).delete();
      } catch (e) {
        debugPrint('Firestore sync failed: $e');
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleComplete({required String id}) async {
    try {
      final box = await _taskBox;
      final taskMap = box.get(id);
      if (taskMap != null) {
        final taskMapCast = _recursiveCast(Map<dynamic, dynamic>.from(taskMap));
        final newValue = !taskMapCast['isCompleted'];
        taskMapCast['isCompleted'] = newValue;
        await box.put(id, taskMapCast);

        try {
          await _firestoreTasks.doc(id).update({'isCompleted': newValue});
        } catch (e) {
          debugPrint('Firestore sync failed: $e');
        }

        // Cancel notification if completed
        if (newValue) {
          final taskModel = TaskModel.fromJson(taskMapCast);
          await _notificationService.cancelNotification(
            taskModel.notificationId,
          );
          await _notificationService.cancelNotification(
            taskModel.notificationId + 100000,
          );

          // Handle Recurring Task Creation
          final task = taskModel.toEntity();
          if (task.recurringType != RecurringType.none) {
            DateTime nextDueDate = task.dueDate;
            final interval =
                task.recurringInterval > 0 ? task.recurringInterval : 1;

            switch (task.recurringType) {
              case RecurringType.daily:
                nextDueDate = task.dueDate.add(Duration(days: interval));
                break;
              case RecurringType.weekly:
                nextDueDate = task.dueDate.add(Duration(days: 7 * interval));
                break;
              case RecurringType.monthly:
                // Simple monthly increment
                var newMonth = task.dueDate.month + interval;
                var newYear = task.dueDate.year;
                if (newMonth > 12) {
                  newYear += newMonth ~/ 12;
                  newMonth = newMonth % 12;
                  if (newMonth == 0) {
                    newMonth = 12;
                    newYear -= 1;
                  }
                }
                // Handle day overflow (e.g., Jan 31 -> Feb 28)
                int day = task.dueDate.day;
                int daysInMonth = DateTime(newYear, newMonth + 1, 0).day;
                if (day > daysInMonth) {
                  day = daysInMonth;
                }

                nextDueDate = DateTime(
                  newYear,
                  newMonth,
                  day,
                  task.dueDate.hour,
                  task.dueDate.minute,
                );
                break;
              case RecurringType.none:
                break;
            }

            final newTask = Task(
              id: const Uuid().v4(),
              notificationId: DateTime.now().millisecondsSinceEpoch ~/ 1000,
              title: task.title,
              description: task.description,
              dueDate: nextDueDate,
              alarmSet: task.alarmSet,
              remind5MinEarly: task.remind5MinEarly,
              priority: task.priority,
              category: task.category,
              tags: task.tags,
              recurringType: task.recurringType,
              recurringInterval: task.recurringInterval,
            );

            debugPrint(
              'Generating next recurring task: ${newTask.title} on ${newTask.dueDate}',
            );
            await addTask(task: newTask);
          }
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleAlarm({required String id}) async {
    try {
      final box = await _taskBox;
      final taskMap = box.get(id);
      if (taskMap != null) {
        final taskMapCast = _recursiveCast(Map<dynamic, dynamic>.from(taskMap));
        final newValue = !taskMapCast['alarmSet'];
        taskMapCast['alarmSet'] = newValue;
        await box.put(id, taskMapCast);

        try {
          await _firestoreTasks.doc(id).update({'alarmSet': newValue});
        } catch (e) {
          debugPrint('Firestore sync failed: $e');
        }

        final taskModel = TaskModel.fromJson(taskMapCast);
        final task = taskModel.toEntity();

        if (newValue) {
          // Schedule
          await _notificationService.ensureInitialized();
          await _notificationService.scheduleNotification(
            id: task.notificationId,
            title: task.title,
            body: task.description ?? 'Task Reminder',
            scheduledDate: task.dueDate,
          );
          if (task.remind5MinEarly) {
            await _notificationService.ensureInitialized();
            await _notificationService.scheduleNotification(
              id: task.notificationId + 100000,
              title: 'Upcoming: ${task.title}',
              body: '5 minutes until due',
              scheduledDate: task.dueDate.subtract(const Duration(minutes: 5)),
            );
          }
        } else {
          // Cancel
          await _notificationService.cancelNotification(task.notificationId);
          await _notificationService.cancelNotification(
            task.notificationId + 100000,
          );
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> searchTasks(String query) async {
    final result = await getTasks();
    return result.map((tasks) {
      if (query.isEmpty) return tasks;
      final lowercaseQuery = query.toLowerCase();
      return tasks.where((task) {
        final titleMatch = task.title.toLowerCase().contains(lowercaseQuery);
        final descMatch =
            task.description?.toLowerCase().contains(lowercaseQuery) ?? false;
        return titleMatch || descMatch;
      }).toList();
    });
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByCategory(
    TaskCategory category,
  ) async {
    final result = await getTasks();
    return result.map(
      (tasks) => tasks.where((task) => task.category == category).toList(),
    );
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByTags(List<String> tags) async {
    final result = await getTasks();
    if (tags.isEmpty) return result;
    return result.map((tasks) {
      return tasks.where((task) {
        return tags.any((tag) => task.tags.contains(tag));
      }).toList();
    });
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final result = await getTasks();
    return result.map((tasks) {
      return tasks.where((task) {
        return task.dueDate.isAfter(start) && task.dueDate.isBefore(end);
      }).toList();
    });
  }
}
