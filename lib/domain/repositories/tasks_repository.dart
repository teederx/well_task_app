import 'package:well_task_app/data/models/subtask_model/subtask_model.dart';
import 'package:well_task_app/data/models/time_log_model/time_log_model.dart';
import 'package:well_task_app/data/models/attachment_model/attachment_model.dart';

import '../../data/models/task_model/task_model.dart';
import '../../data/models/task_model/task_enums.dart';

abstract class TasksRepository {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask({required TaskModel task});
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
  });
  Future<void> toggleComplete({required String id});
  Future<void> toggleAlarm({required String id});
  Future<void> removeTask({required String id});
  Future<List<TaskModel>> searchTasks(String query);
  Future<List<TaskModel>> getTasksByCategory(TaskCategory category);
  Future<List<TaskModel>> getTasksByTags(List<String> tags);
  Future<List<TaskModel>> getTasksByDateRange(DateTime start, DateTime end);
}
