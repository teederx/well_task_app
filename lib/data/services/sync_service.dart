import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:well_task_app/presentation/providers/connectivity_provider.dart';
import 'package:well_task_app/presentation/providers/tasks_providers/task_list/task_list_provider.dart';

class SyncService {
  final Ref ref;

  SyncService(this.ref) {
    _init();
  }

  void _init() {
    // Listen to connectivity changes
    ref.listen(isOfflineProvider, (previous, next) {
      if (previous == true && next == false) {
        // We just went online!
        _performSync();
      }
    });
  }

  Future<void> _performSync() async {
    // Trigger a refresh of the task list to sync with Firestore
    // Firestore handles the actual queuing, but this ensures UI is up to date
    // and any pending writes are pushed if the app was in a background state.
    ref.invalidate(taskListProvider);
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(ref);
});
