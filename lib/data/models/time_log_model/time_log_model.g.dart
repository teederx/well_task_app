// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeLogModel _$TimeLogModelFromJson(Map<String, dynamic> json) =>
    _TimeLogModel(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime:
          json['endTime'] == null
              ? null
              : DateTime.parse(json['endTime'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TimeLogModelToJson(_TimeLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration,
      'note': instance.note,
    };
