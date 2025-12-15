import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_task_app/core/utils/config/notification_sound_prefs.dart';

final notificationSoundProvider = StateNotifierProvider<NotificationSoundNotifier, NotificationSoundOption>(
  (ref) => NotificationSoundNotifier(),
);

class NotificationSoundNotifier extends StateNotifier<NotificationSoundOption> {
  NotificationSoundNotifier() : super(NotificationSoundOption.system) {
    _load();
  }

  Future<void> _load() async {
    state = await NotificationSoundPrefs.load();
  }

  Future<void> setSound(NotificationSoundOption option) async {
    state = option;
    await NotificationSoundPrefs.save(option);
  }
}


