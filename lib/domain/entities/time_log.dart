import 'package:equatable/equatable.dart';

class TimeLog extends Equatable {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int duration;
  final String? note;

  const TimeLog({
    required this.id,
    required this.startTime,
    this.endTime,
    this.duration = 0,
    this.note,
  });

  TimeLog copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    int? duration,
    String? note,
  }) {
    return TimeLog(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [id, startTime, endTime, duration, note];
}


