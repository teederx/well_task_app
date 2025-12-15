import 'package:fpdart/fpdart.dart' hide Task;
import '../../core/errors/failure.dart';
import '../entities/task.dart';
import '../entities/task_enums.dart';
import '../entities/subtask.dart';
import '../entities/time_log.dart';
import '../entities/attachment.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, void>> addTask({required Task task});
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
  });
  Future<Either<Failure, void>> toggleComplete({required String id});
  Future<Either<Failure, void>> toggleAlarm({required String id});
  Future<Either<Failure, void>> removeTask({required String id});
  Future<Either<Failure, List<Task>>> searchTasks(String query);
  Future<Either<Failure, List<Task>>> getTasksByCategory(TaskCategory category);
  Future<Either<Failure, List<Task>>> getTasksByTags(List<String> tags);
  Future<Either<Failure, List<Task>>> getTasksByDateRange(
    DateTime start,
    DateTime end,
  );
}


