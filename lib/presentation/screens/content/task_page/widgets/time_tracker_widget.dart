import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:well_task_app/domain/entities/task.dart';
import 'package:well_task_app/domain/entities/time_log.dart';
import 'package:well_task_app/core/utils/constants/app_theme.dart';

class TimeTrackerWidget extends ConsumerStatefulWidget {
  final Task task;
  final Function(
    bool isRunning,
    DateTime? startTime,
    int totalDuration,
    List<TimeLog> logs,
  )
  onTimerChanged;

  const TimeTrackerWidget({
    super.key,
    required this.task,
    required this.onTimerChanged,
  });

  @override
  ConsumerState<TimeTrackerWidget> createState() => _TimeTrackerWidgetState();
}

class _TimeTrackerWidgetState extends ConsumerState<TimeTrackerWidget> {
  Timer? _timer;
  late int _currentSessionDuration;
  late bool _isRunning;
  late int _totalDuration;
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _isRunning = widget.task.isTimerRunning;
    _totalDuration = widget.task.totalTimeSpent;
    _currentSessionDuration = 0;

    if (_isRunning && widget.task.timerStartedAt != null) {
      _resumeTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resumeTimer() {
    final now = DateTime.now();
    final difference = now.difference(widget.task.timerStartedAt!);
    setState(() {
      _currentSessionDuration = difference.inSeconds;
    });
    _startTicker();
  }

  void _startTicker() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentSessionDuration++;
      });
    });
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        // Stop Timer
        _timer?.cancel();
        _isRunning = false;

        final endTime = DateTime.now();
        final startTime =
            widget.task.timerStartedAt ??
            DateTime.now().subtract(Duration(seconds: _currentSessionDuration));
        final newLog = TimeLog(
          id: _uuid.v4(),
          startTime: startTime,
          endTime: endTime,
          duration: _currentSessionDuration,
        );

        _totalDuration += _currentSessionDuration;
        _currentSessionDuration = 0;

        final newLogs = [...widget.task.timeLogs, newLog];

        widget.onTimerChanged(false, null, _totalDuration, newLogs);
      } else {
        // Start Timer
        _isRunning = true;
        final startTime = DateTime.now();
        widget.onTimerChanged(
          true,
          startTime,
          _totalDuration,
          widget.task.timeLogs,
        );
        _startTicker();
      }
    });
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final h = duration.inHours;
    final m = duration.inMinutes.remainder(60);
    final s = duration.inSeconds.remainder(60);
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppTheme.purple.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined, color: AppTheme.purple, size: 24.sp),
              10.horizontalSpace,
              Text(
                'Time Tracker',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.purple,
                ),
              ),
              const Spacer(),
              Text(
                _formatDuration(
                  _totalDuration + (_isRunning ? _currentSessionDuration : 0),
                ),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Optician',
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _toggleTimer,
                  icon: Icon(_isRunning ? Icons.stop : Icons.play_arrow),
                  label: Text(_isRunning ? 'Stop Timer' : 'Start Timer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? AppTheme.red : AppTheme.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (widget.task.timeLogs.isNotEmpty) ...[
            16.verticalSpace,
            Divider(color: Colors.grey[200]),
            8.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            8.verticalSpace,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  widget.task.timeLogs.length > 3
                      ? 3
                      : widget.task.timeLogs.length,
              itemBuilder: (context, index) {
                // Show most recent first
                final log =
                    widget.task.timeLogs[widget.task.timeLogs.length -
                        1 -
                        index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Text(
                        _formatDuration(log.duration),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      10.horizontalSpace,
                      Text(
                        '${log.startTime.day}/${log.startTime.month} ${log.startTime.hour}:${log.startTime.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}


