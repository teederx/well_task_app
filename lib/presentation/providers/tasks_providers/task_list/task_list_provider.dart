import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_enums.dart';
import '../../../../domain/entities/subtask.dart';
import '../../../../domain/entities/time_log.dart';
import '../../../../domain/entities/attachment.dart';
import '../../../../domain/usecases/tasks/edit_task_usecase.dart';

import '../use_cases/tasks_use_case_provider.dart';

part 'task_list_provider.g.dart';

const uuid = Uuid();

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    final getTasks = ref.read(getTasksUseCaseProvider);
    final result = await getTasks(NoParams());
    return result.fold((failure) {
      debugPrint('TaskList build error: ${failure.message}');
      return [];
    }, (tasks) => tasks);
  }

  Future<void> addTask({
    required int notId,
    required String title,
    required String desc,
    required DateTime dueDate,
    required bool alarmSet,
    required bool remind5MinEarly,
    required TaskPriority priority,
    String? id,
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
    final addTask = ref.read(addTaskUseCaseProvider);
    final task = Task(
      id: id ?? const Uuid().v4(),
      notificationId: notId,
      title: title,
      description: desc,
      dueDate: dueDate,
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

    final result = await addTask(task);
    result.fold(
      (failure) => debugPrint('Add task failed: ${failure.message}'),
      (_) => ref.invalidateSelf(),
    );
  }

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
    List<Subtask> subtasks = const [],
    int totalTimeSpent = 0,
    List<TimeLog> timeLogs = const [],
    DateTime? timerStartedAt,
    bool isTimerRunning = false,
    List<Attachment> attachments = const [],
  }) async {
    final editTask = ref.read(editTaskUseCaseProvider);
    final params = EditTaskParams(
      id: id,
      title: title,
      desc: desc,
      dueDate: dueDate,
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

    final result = await editTask(params);
    result.fold(
      (failure) => debugPrint('Edit task failed: ${failure.message}'),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> removeTask({required String id}) async {
    final removeTask = ref.read(removeTaskUseCaseProvider);
    final result = await removeTask(id);
    result.fold(
      (failure) => debugPrint('Remove task failed: ${failure.message}'),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> toggleComplete({required String id}) async {
    final toggleComplete = ref.read(toggleCompleteUseCaseProvider);
    final result = await toggleComplete(id);
    result.fold(
      (failure) => debugPrint('Toggle complete failed: ${failure.message}'),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> toggleAlarm({required String id}) async {
    final toggleAlarm = ref.read(toggleAlarmUseCaseProvider);
    final result = await toggleAlarm(id);
    result.fold(
      (failure) => debugPrint('Toggle alarm failed: ${failure.message}'),
      (_) => ref.invalidateSelf(),
    );
  }
}


