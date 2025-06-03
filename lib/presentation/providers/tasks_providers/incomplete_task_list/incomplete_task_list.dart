import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../task_list/task_list_provider.dart';

part 'incomplete_task_list.g.dart';

@riverpod
List<TaskModel> incompleteTaskList(Ref ref) {
  final taskListAsync = ref.watch(taskListProvider);

  return taskListAsync.maybeWhen(
    data: (taskList) {
      final incompleteTasks =
          taskList.where((task) => !task.isCompleted).toList();
      return incompleteTasks;
    },
    orElse: () => [],
  );
}
