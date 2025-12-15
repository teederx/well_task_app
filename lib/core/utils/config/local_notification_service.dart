import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:well_task_app/presentation/screens/content/main_screen/main_screen.dart';
import 'package:well_task_app/core/utils/config/router/route_provider.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'notification_sound_prefs.dart';

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
  // Handle background notification response if needed
  debugPrint('Background Notification Response: ${response.payload}');
}

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> ensureInitialized() async {
    if (_initialized) return;
    await initialize();
  }

  Future<void> initialize() async {
    if (_initialized) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationResponse(response);
      },
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    // Create notification channels explicitly
    await _createNotificationChannels();

    // Handle initial notification if app was closed
    final NotificationAppLaunchDetails? launchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      if (launchDetails?.notificationResponse != null) {
        _handleNotificationResponse(launchDetails!.notificationResponse!);
      }
    }

    _initialized = true;
  }

  Future<void> _createNotificationChannels() async {
    const taskChannel = AndroidNotificationChannel(
      'task_channel_id',
      'Task Reminders',
      description: 'Channel for task reminders',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
      enableVibration: true,
    );

    const dailyChannel = AndroidNotificationChannel(
      'daily_channel_id',
      'Daily Reminders',
      description: 'Channel for daily reminders',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
      enableVibration: true,
    );

    final androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    await androidPlugin?.createNotificationChannel(taskChannel);
    await androidPlugin?.createNotificationChannel(dailyChannel);
  }

  Future<void> _handleNotificationResponse(
    NotificationResponse response,
  ) async {
    final taskId = response.payload;
    if (taskId != null) {
      // Wait for context to be available if app is just starting
      int retryCount = 0;
      while (rootNavigatorKey.currentContext == null && retryCount < 50) {
        await Future.delayed(const Duration(milliseconds: 100));
        retryCount++;
      }

      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        // ignore: use_build_context_synchronously
        context.pushNamed(
          'task',
          pathParameters: {'id': taskId, 'pageType': PageType.viewTask.name},
        );
      }
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await ensureInitialized();
    await checkAndPromptExactAlarmPermission();

    final soundPreference = await NotificationSoundPrefs.load();
    final androidSound =
        soundPreference == NotificationSoundOption.alarm
            ? const RawResourceAndroidNotificationSound('alarm')
            : null;
    final iosSound =
        soundPreference == NotificationSoundOption.alarm ? 'alarm.wav' : null;

    final androidDetails = AndroidNotificationDetails(
      'task_channel_id',
      'Task Reminders',
      channelDescription: 'Channel for task reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: androidSound,
      enableVibration: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
    );
    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: iosSound,
    );
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Ensure scheduled date is in the future
    if (scheduledDate.isBefore(DateTime.now())) {
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await ensureInitialized();
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'daily_channel_id',
      'Daily Reminders',
      channelDescription: 'Channel for daily reminders',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
      enableVibration: true,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'alarm.wav',
    );
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> requestNotificationPermissions() async {
    final androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidPlugin?.requestNotificationsPermission();

    final iosPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
    await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);

    // Android 13+ (API 33) runtime notification permission
    if (Platform.isAndroid) {
      final sdk = int.tryParse(Platform.version.split(" ").first);
      if (sdk != null && sdk >= 33) {
        final status = await Permission.notification.status;
        if (!status.isGranted) {
          await Permission.notification.request();
        }
      }
      await checkAndPromptBatteryOptimization();
    }
  }

  Future<void> checkAndPromptBatteryOptimization() async {
    if (Platform.isAndroid) {
      final isIgnoring = await Permission.ignoreBatteryOptimizations.isGranted;
      if (!isIgnoring) {
        final intent = AndroidIntent(
          action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
          data: 'package:com.example.well_task_app',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      }
    }
  }

  Future<void> checkAndPromptExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final sdkInt = int.tryParse(Platform.version.split(' ').first);
      if (sdkInt != null && sdkInt >= 31) {
        if (await Permission.scheduleExactAlarm.isDenied) {
          final intent = AndroidIntent(
            action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
            flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
          );
          await intent.launch();
        }
      }
    }
  }
}
