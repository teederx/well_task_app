// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: json['id'] as String,
  notificationId: (json['notificationId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  dueDate: DateTime.parse(json['dueDate'] as String),
  isCompleted: json['isCompleted'] as bool? ?? false,
  alarmSet: json['alarmSet'] as bool? ?? false,
  remind5MinEarly: json['remind5MinEarly'] as bool? ?? false,
  priority:
      $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
      TaskPriority.medium,
  category:
      $enumDecodeNullable(_$TaskCategoryEnumMap, json['category']) ??
      TaskCategory.other,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  recurringType:
      $enumDecodeNullable(_$RecurringTypeEnumMap, json['recurringType']) ??
      RecurringType.none,
  recurringInterval: (json['recurringInterval'] as num?)?.toInt() ?? 1,
  subtasks:
      (json['subtasks'] as List<dynamic>?)
          ?.map((e) => SubtaskModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalTimeSpent: (json['totalTimeSpent'] as num?)?.toInt() ?? 0,
  timeLogs:
      (json['timeLogs'] as List<dynamic>?)
          ?.map((e) => TimeLogModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  timerStartedAt:
      json['timerStartedAt'] == null
          ? null
          : DateTime.parse(json['timerStartedAt'] as String),
  isTimerRunning: json['isTimerRunning'] as bool? ?? false,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'notificationId': instance.notificationId,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'alarmSet': instance.alarmSet,
      'remind5MinEarly': instance.remind5MinEarly,
      'priority': _$TaskPriorityEnumMap[instance.priority]!,
      'category': _$TaskCategoryEnumMap[instance.category]!,
      'tags': instance.tags,
      'recurringType': _$RecurringTypeEnumMap[instance.recurringType]!,
      'recurringInterval': instance.recurringInterval,
      'subtasks': instance.subtasks.map((e) => e.toJson()).toList(),
      'totalTimeSpent': instance.totalTimeSpent,
      'timeLogs': instance.timeLogs.map((e) => e.toJson()).toList(),
      'timerStartedAt': instance.timerStartedAt?.toIso8601String(),
      'isTimerRunning': instance.isTimerRunning,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
    };

const _$TaskPriorityEnumMap = {
  TaskPriority.low: 'low',
  TaskPriority.medium: 'medium',
  TaskPriority.high: 'high',
};

const _$TaskCategoryEnumMap = {
  TaskCategory.work: 'work',
  TaskCategory.personal: 'personal',
  TaskCategory.health: 'health',
  TaskCategory.shopping: 'shopping',
  TaskCategory.study: 'study',
  TaskCategory.finance: 'finance',
  TaskCategory.social: 'social',
  TaskCategory.travel: 'travel',
  TaskCategory.other: 'other',
};

const _$RecurringTypeEnumMap = {
  RecurringType.none: 'none',
  RecurringType.daily: 'daily',
  RecurringType.weekly: 'weekly',
  RecurringType.monthly: 'monthly',
};
