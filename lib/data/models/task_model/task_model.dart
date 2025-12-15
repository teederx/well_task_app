import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:well_task_app/data/models/subtask_model/subtask_model.dart';
import 'package:well_task_app/data/models/time_log_model/time_log_model.dart';
import 'package:well_task_app/data/models/attachment_model/attachment_model.dart';
import 'package:well_task_app/domain/entities/task_enums.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

const Uuid uuid = Uuid();

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required int notificationId,
    required String title,
    String? description,
    required DateTime dueDate,
    @Default(false) bool isCompleted,
    @Default(false) bool alarmSet,
    @Default(false) bool remind5MinEarly,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default(TaskCategory.other) TaskCategory category,
    @Default([]) List<String> tags,
    @Default(RecurringType.none) RecurringType recurringType,
    @Default(1) int recurringInterval,
    @Default([]) List<SubtaskModel> subtasks,
    @Default(0) int totalTimeSpent,
    @Default([]) List<TimeLogModel> timeLogs,
    DateTime? timerStartedAt,
    @Default(false) bool isTimerRunning,
    @Default([]) List<AttachmentModel> attachments,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.createTask({
    required String id,
    required String title,
    required int notificationId,
    String? description,
    required DateTime dueDate,
    bool alarmSet = false,
    bool remind5MinEarly = false,
    TaskPriority priority = TaskPriority.medium,
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
  }) {
    return TaskModel(
      id: id,
      notificationId: notificationId,
      title: title,
      description: description,
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
  }
}


