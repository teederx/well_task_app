import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:well_task_app/data/models/subtask_model/subtask_model.dart';
import 'package:well_task_app/data/models/time_log_model/time_log_model.dart';
import 'package:well_task_app/data/models/attachment_model/attachment_model.dart';

import '../../../domain/repositories/tasks_repository.dart';
import '../../../utils/config/local_notification_service.dart';
import '../../../utils/constants/firebase_constants.dart';
import '../../models/task_model/task_model.dart';
import '../../models/task_model/task_enums.dart';

class TasksRepositoryImpl implements TasksRepository {
  Future<Box> get _taskBox async {
    final userId = fbAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not authenticated");
    if (!Hive.isBoxOpen('Tasks_$userId')) {
      await Hive.openBox('Tasks_$userId');
    }
    return Hive.box('Tasks_$userId');
  }

  CollectionReference get _firestoreTasks {
    final userId = fbAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not authenticated");
    return usersCollection.doc(userId).collection('tasks');
  }

  final LocalNotificationService _notificationService =
      LocalNotificationService();

  @override
  Future<void> addTask({required TaskModel task}) async {
    // 1. Save to Local Hive
    final box = await _taskBox;
    await box.put(task.id, task.toJson());

    // 2. Sync to Firestore
    try {
      await _firestoreTasks.doc(task.id).set(task.toJson());
    } catch (e) {
      debugPrint('Firestore sync failed: $e');
    }

    // 3. Schedule Notification
    if (task.alarmSet) {
      await _notificationService.scheduleNotification(
        id: task.notificationId,
        title: task.title,
        body: task.description ?? 'Task Reminder',
        scheduledDate: task.dueDate,
      );

      if (task.remind5MinEarly) {
        await _notificationService.scheduleNotification(
          id: task.notificationId + 100000, // Offset ID for early reminder
          title: 'Upcoming: ${task.title}',
          body: '5 minutes until due',
          scheduledDate: task.dueDate.subtract(const Duration(minutes: 5)),
        );
      }
    }
  }

  @override
  Future<void> editTask({
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
    List<SubtaskModel> subtasks = const [],
    int totalTimeSpent = 0,
    List<TimeLogModel> timeLogs = const [],
    DateTime? timerStartedAt,
    bool isTimerRunning = false,
    List<AttachmentModel> attachments = const [],
  }) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      final oldTask = TaskModel.fromJson(Map<String, dynamic>.from(taskMap));

      taskMap['description'] = desc;
      taskMap['title'] = title;
      taskMap['dueDate'] = dueDate;
      taskMap['alarmSet'] = alarmSet;
      taskMap['remind5MinEarly'] = remind5MinEarly;
      taskMap['priority'] = priority.name;
      taskMap['category'] = category.name;
      taskMap['tags'] = tags;
      taskMap['recurringType'] = recurringType.name;
      taskMap['recurringInterval'] = recurringInterval;
      taskMap['subtasks'] = subtasks.map((s) => s.toJson()).toList();
      taskMap['totalTimeSpent'] = totalTimeSpent;
      taskMap['timeLogs'] = timeLogs.map((log) => log.toJson()).toList();
      taskMap['timerStartedAt'] = timerStartedAt?.toIso8601String();
      taskMap['isTimerRunning'] = isTimerRunning;
      taskMap['attachments'] = attachments.map((a) => a.toJson()).toList();

      // 1. Update Local
      await box.put(id, taskMap);

      // 2. Update Firestore
      try {
        await _firestoreTasks.doc(id).update({
          'description': desc,
          'title': title,
          'dueDate': dueDate.toIso8601String(),
          'alarmSet': alarmSet,
          'remind5MinEarly': remind5MinEarly,
          'priority': priority.name,
          'category': category.name,
          'tags': tags,
          'recurringType': recurringType.name,
          'recurringInterval': recurringInterval,
          'subtasks': subtasks.map((s) => s.toJson()).toList(),
          'totalTimeSpent': totalTimeSpent,
          'timeLogs': timeLogs.map((log) => log.toJson()).toList(),
          'timerStartedAt': timerStartedAt?.toIso8601String(),
          'isTimerRunning': isTimerRunning,
          'attachments': attachments.map((a) => a.toJson()).toList(),
        });
      } catch (e) {
        debugPrint('Firestore sync failed: $e');
      }

      // 3. Update Notifications
      // Cancel old ones first
      await _notificationService.cancelNotification(oldTask.notificationId);
      await _notificationService.cancelNotification(
        oldTask.notificationId + 100000,
      );

      if (alarmSet) {
        await _notificationService.scheduleNotification(
          id: oldTask.notificationId,
          title: title,
          body: desc.isEmpty ? 'Task Reminder' : desc,
          scheduledDate: dueDate,
        );

        if (remind5MinEarly) {
          await _notificationService.scheduleNotification(
            id: oldTask.notificationId + 100000,
            title: 'Upcoming: $title',
            body: '5 minutes until due',
            scheduledDate: dueDate.subtract(const Duration(minutes: 5)),
          );
        }
      }
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final box = await _taskBox;

    // Trigger background sync
    _syncFromFirestore();

    return box.values
        .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
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
  Future<void> removeTask({required String id}) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      final task = TaskModel.fromJson(Map<String, dynamic>.from(taskMap));
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
  }

  @override
  Future<void> toggleComplete({required String id}) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      final newValue = !taskMap['isCompleted'];
      taskMap['isCompleted'] = newValue;
      await box.put(id, taskMap);

      try {
        await _firestoreTasks.doc(id).update({'isCompleted': newValue});
      } catch (e) {
        debugPrint('Firestore sync failed: $e');
      }

      // Cancel notification if completed
      if (newValue) {
        final task = TaskModel.fromJson(Map<String, dynamic>.from(taskMap));
        await _notificationService.cancelNotification(task.notificationId);
        await _notificationService.cancelNotification(
          task.notificationId + 100000,
        );

        // Handle Recurring Task Creation
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

          // Create the new task
          final newTask = TaskModel.createTask(
            id: uuid.v4(),
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
  }

  @override
  Future<void> toggleAlarm({required String id}) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      final newValue = !taskMap['alarmSet'];
      taskMap['alarmSet'] = newValue;
      await box.put(id, taskMap);

      try {
        await _firestoreTasks.doc(id).update({'alarmSet': newValue});
      } catch (e) {
        debugPrint('Firestore sync failed: $e');
      }

      final task = TaskModel.fromJson(Map<String, dynamic>.from(taskMap));
      if (newValue) {
        // Schedule
        await _notificationService.scheduleNotification(
          id: task.notificationId,
          title: task.title,
          body: task.description ?? 'Task Reminder',
          scheduledDate: task.dueDate,
        );
        if (task.remind5MinEarly) {
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
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async {
    final tasks = await getTasks();
    if (query.isEmpty) return tasks;

    final lowercaseQuery = query.toLowerCase();
    return tasks.where((task) {
      final titleMatch = task.title.toLowerCase().contains(lowercaseQuery);
      final descMatch =
          task.description?.toLowerCase().contains(lowercaseQuery) ?? false;
      return titleMatch || descMatch;
    }).toList();
  }

  @override
  Future<List<TaskModel>> getTasksByCategory(TaskCategory category) async {
    final tasks = await getTasks();
    return tasks.where((task) => task.category == category).toList();
  }

  @override
  Future<List<TaskModel>> getTasksByTags(List<String> tags) async {
    final tasks = await getTasks();
    if (tags.isEmpty) return tasks;
    return tasks.where((task) {
      return tags.any((tag) => task.tags.contains(tag));
    }).toList();
  }

  @override
  Future<List<TaskModel>> getTasksByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final tasks = await getTasks();
    return tasks.where((task) {
      return task.dueDate.isAfter(start) && task.dueDate.isBefore(end);
    }).toList();
  }
}
