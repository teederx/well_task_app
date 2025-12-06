import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  static const String _boxName = 'settings_box';
  static const String _dailyReminderEnabledKey = 'daily_reminder_enabled';
  static const String _dailyReminderTimeKey = 'daily_reminder_time';

  Future<Box> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
    return Hive.box(_boxName);
  }

  Future<void> setDailyReminderEnabled(bool enabled) async {
    final box = await _box;
    await box.put(_dailyReminderEnabledKey, enabled);
  }

  Future<bool> getDailyReminderEnabled() async {
    final box = await _box;
    return box.get(_dailyReminderEnabledKey, defaultValue: false);
  }

  Future<void> setDailyReminderTime(TimeOfDay time) async {
    final box = await _box;
    await box.put(_dailyReminderTimeKey, '${time.hour}:${time.minute}');
  }

  Future<TimeOfDay> getDailyReminderTime() async {
    final box = await _box;
    final timeString = box.get(_dailyReminderTimeKey, defaultValue: '08:00');
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository();
}
