import 'package:equatable/equatable.dart';
import 'attachment.dart';
import 'subtask.dart';
import 'task_enums.dart';
import 'time_log.dart';

class Task extends Equatable {
  final String id;
  final int notificationId;
  final String title;
  final String? description;
  final DateTime dueDate;
  final bool isCompleted;
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

  const Task({
    required this.id,
    required this.notificationId,
    required this.title,
    this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.alarmSet = false,
    this.remind5MinEarly = false,
    this.priority = TaskPriority.medium,
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

  Task copyWith({
    String? id,
    int? notificationId,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    bool? alarmSet,
    bool? remind5MinEarly,
    TaskPriority? priority,
    TaskCategory? category,
    List<String>? tags,
    RecurringType? recurringType,
    int? recurringInterval,
    List<Subtask>? subtasks,
    int? totalTimeSpent,
    List<TimeLog>? timeLogs,
    DateTime? timerStartedAt,
    bool? isTimerRunning,
    List<Attachment>? attachments,
  }) {
    return Task(
      id: id ?? this.id,
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      alarmSet: alarmSet ?? this.alarmSet,
      remind5MinEarly: remind5MinEarly ?? this.remind5MinEarly,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      recurringType: recurringType ?? this.recurringType,
      recurringInterval: recurringInterval ?? this.recurringInterval,
      subtasks: subtasks ?? this.subtasks,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      timeLogs: timeLogs ?? this.timeLogs,
      timerStartedAt: timerStartedAt ?? this.timerStartedAt,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      attachments: attachments ?? this.attachments,
    );
  }

  @override
  List<Object?> get props => [
    id,
    notificationId,
    title,
    description,
    dueDate,
    isCompleted,
    alarmSet,
    remind5MinEarly,
    priority,
    category,
    tags,
    recurringType,
    recurringInterval,
    subtasks,
    totalTimeSpent,
    timeLogs,
    timerStartedAt,
    isTimerRunning,
    attachments,
  ];
}


