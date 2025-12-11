import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/models/subtask_model/subtask_model.dart';
import '../../../../data/models/task_model/task_enums.dart';
import '../../../../data/models/task_model/task_model.dart';
import '../../../../data/repositories/tasks_repository/provider/tasks_repository_provider.dart';

import '../../../../data/models/time_log_model/time_log_model.dart';
import '../../../../data/models/attachment_model/attachment_model.dart';

part 'task_list_provider.g.dart';

const uuid = Uuid();

@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<TaskModel>> build() async {
    final repository = ref.read(tasksRepositoryProvider);
    try {
      return await repository.getTasks();
    } catch (e, _) {
      // Avoid crashing the UI if auth is missing or storage fails.
      // debugPrint('TaskList build error: $e');
      // debugPrint('$st');
      return [];
    }
  }

  Future<void> addTask({
    required String id,
    required int notId,
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
    final repository = ref.read(tasksRepositoryProvider);
    final task = TaskModel.createTask(
      id: id,
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
    await repository.addTask(task: task);
    ref.invalidateSelf();
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
    List<SubtaskModel> subtasks = const [],
    int totalTimeSpent = 0,
    List<TimeLogModel> timeLogs = const [],
    DateTime? timerStartedAt,
    bool isTimerRunning = false,
    List<AttachmentModel> attachments = const [],
  }) async {
    final repository = ref.read(tasksRepositoryProvider);
    await repository.editTask(
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
      // Note: repository.editTask likely needs update too if it copies fields manually
      // but if it replaces the task or uses helper, we need to pass these params
      // Assuming repository.editTask takes named args matching TaskModel fields or a TaskModel object.
      // Checking local cache of TasksRepository... wait, I need to check TasksRepository.
      subtasks: subtasks,
      totalTimeSpent: totalTimeSpent,
      timeLogs: timeLogs,
      timerStartedAt: timerStartedAt,
      isTimerRunning: isTimerRunning,
      attachments: attachments,
    );
    ref.invalidateSelf();
  }

  Future<void> removeTask({required String id}) async {
    final repository = ref.read(tasksRepositoryProvider);
    await repository.removeTask(id: id);
    ref.invalidateSelf();
  }

  Future<void> toggleComplete({required String id}) async {
    final repository = ref.read(tasksRepositoryProvider);
    await repository.toggleComplete(id: id);
    ref.invalidateSelf();
  }

  Future<void> toggleAlarm({required String id}) async {
    final repository = ref.read(tasksRepositoryProvider);
    await repository.toggleAlarm(id: id);
    ref.invalidateSelf();
  }
}
