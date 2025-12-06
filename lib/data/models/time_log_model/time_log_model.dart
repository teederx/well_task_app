import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_log_model.freezed.dart';
part 'time_log_model.g.dart';

@freezed
abstract class TimeLogModel with _$TimeLogModel {
  const factory TimeLogModel({
    required String id,
    required DateTime startTime,
    DateTime? endTime,
    @Default(0) int duration, // duration in seconds
    String? note,
  }) = _TimeLogModel;

  factory TimeLogModel.fromJson(Map<String, dynamic> json) =>
      _$TimeLogModelFromJson(json);
}
