import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../task_list/task_list_provider.dart';

part 'task_provider.g.dart';

@riverpod
TaskModel task(Ref ref, {required String id}) {
  final taskListAsync = ref.watch(taskListProvider);

  return taskListAsync.maybeWhen(
    data: (taskList) {
      if (taskList.isEmpty) {
        return TaskModel(
          id: id,
          notificationId: 0,
          title: '',
          dueDate: DateTime.now(),
        );
      }

      final task = taskList.firstWhere(
        (task) => task.id == id,
        orElse: () => TaskModel(
          id: id,
          notificationId: 0,
          title: '',
          dueDate: DateTime.now(),
        ),
      );
      return task;
    },
    orElse: () => TaskModel(id: id, notificationId: 0, title: '', dueDate: DateTime.now()),
  );
}
