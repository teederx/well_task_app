import 'package:hive_flutter/hive_flutter.dart';

enum NotificationSoundOption { system, alarm }

class NotificationSoundPrefs {
  static const String _boxName = 'settings_box';
  static const String _soundKey = 'notification_sound';

  static Future<Box> _box() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
    return Hive.box(_boxName);
  }

  static Future<NotificationSoundOption> load() async {
    final box = await _box();
    final stored =
        box.get(_soundKey, defaultValue: NotificationSoundOption.system.name)
            as String;
    return NotificationSoundOption.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => NotificationSoundOption.system,
    );
  }

  static Future<void> save(NotificationSoundOption option) async {
    final box = await _box();
    await box.put(_soundKey, option.name);
  }
}
