import 'package:fpdart/fpdart.dart' hide Task;
import 'package:well_task_app/core/errors/failure.dart';
import 'package:well_task_app/core/usecase/usecase.dart';
import '../../entities/attachment.dart';
import '../../entities/subtask.dart';
import '../../entities/task_enums.dart';
import '../../entities/time_log.dart';
import '../../repositories/tasks_repository.dart';

class EditTaskParams {
  final String id;
  final String title;
  final String desc;
  final DateTime dueDate;
  final bool alarmSet;
  final bool remind5MinEarly;
  final TaskPriority priority;
  final TaskCategory category;
  final List<String> tags;
  final RecurringType recurringType;
  final int recurringInterval;
  final List<Subtask> subtasks;
  final int totalTimeSpent;
  final List<TimeLog> timeLogs;
  final DateTime? timerStartedAt;
  final bool isTimerRunning;
  final List<Attachment> attachments;

  EditTaskParams({
    required this.id,
    required this.title,
    required this.desc,
    required this.dueDate,
    required this.alarmSet,
    required this.remind5MinEarly,
    required this.priority,
    this.category = TaskCategory.other,
    this.tags = const [],
    this.recurringType = RecurringType.none,
    this.recurringInterval = 1,
    this.subtasks = const [],
    this.totalTimeSpent = 0,
    this.timeLogs = const [],
    this.timerStartedAt,
    this.isTimerRunning = false,
    this.attachments = const [],
  });
}

class EditTaskUsecase implements UseCase<void, EditTaskParams> {
  final TasksRepository _taskRepository;

  EditTaskUsecase(this._taskRepository);

  @override
  Future<Either<Failure, void>> call(EditTaskParams params) async {
    return await _taskRepository.editTask(
      id: params.id,
      title: params.title,
      desc: params.desc,
      dueDate: params.dueDate,
      alarmSet: params.alarmSet,
      remind5MinEarly: params.remind5MinEarly,
      priority: params.priority,
      category: params.category,
      tags: params.tags,
      recurringType: params.recurringType,
      recurringInterval: params.recurringInterval,
      subtasks: params.subtasks,
      totalTimeSpent: params.totalTimeSpent,
      timeLogs: params.timeLogs,
      timerStartedAt: params.timerStartedAt,
      isTimerRunning: params.isTimerRunning,
      attachments: params.attachments,
    );
  }
}


