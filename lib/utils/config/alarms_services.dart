// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:well_task_app/utils/config/formatted_date_time.dart';
import 'package:well_task_app/utils/config/local_notification_service.dart';

LocalNotificationService _lNS = LocalNotificationService();

abstract class AlarmServices {
  Future<void> scheduleTaskNotification({
    required DateTime dateTime,
    required String id,
    required int notificationId,
    required String title,
    required String desc,
    required BuildContext context,
  });

  Future<void> cancelTaskNotification({
    required int notificationId,
    required DateTime dateTime,
    required String title,
    required BuildContext context,
  });

  Future<void> checkAndPromptExactAlarmPermission();
}

class AlarmServicesImpl implements AlarmServices {
  AlarmServicesImpl();

  @override
  Future<void> scheduleTaskNotification({
    required DateTime dateTime,
    required String id,
    required int notificationId,
    required String title,
    required String? desc,
    required BuildContext context,
  }) async {
    if (title.isEmpty) return;

    await checkAndPromptExactAlarmPermission();

    await _lNS.flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      desc,
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'task_channel_id',
          'Task Reminders',
          channelDescription: 'Scheduled task notifications',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: id,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    _showSnackBar(context, 'Scheduled "$title" for ${formatTime(dateTime)}');
  }

  @override
  Future<void> cancelTaskNotification({
    required int notificationId,
    required DateTime dateTime,
    required String title,
    required BuildContext context,
  }) async {
    if (title.isEmpty) return;

    final isScheduled = await _isNotificationScheduled(notificationId);
    if (isScheduled) {
      await _lNS.flutterLocalNotificationsPlugin.cancel(notificationId);
      _showSnackBar(
        context,
        'Cancelled scheduled task: "$title" for ${formatTime(dateTime)}',
      );
    }
  }

  @override
  Future<void> checkAndPromptExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final sdkInt = int.tryParse(Platform.version.split(' ').first);
      if (sdkInt != null && sdkInt >= 31) {
        final intent = AndroidIntent(
          action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      }
    }
  }

  Future<bool> _isNotificationScheduled(int notificationId) async {
    final pending =
        await _lNS.flutterLocalNotificationsPlugin
            .pendingNotificationRequests();
    return pending.any((notification) => notification.id == notificationId);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.grey,
        ),
      );
  }
}
