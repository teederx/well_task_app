import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../task_list/task_list_provider.dart';

part 'notifications_provider.g.dart';

@riverpod
List<TaskModel> notifications(Ref ref) {
  final taskListAsync = ref.watch(taskListProvider);

  return taskListAsync.maybeWhen(
    data: (taskList) {
      final scheduledTasks = taskList.where((task) => task.alarmSet).toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      return scheduledTasks;
    },
    orElse: () => [],
  );
}
