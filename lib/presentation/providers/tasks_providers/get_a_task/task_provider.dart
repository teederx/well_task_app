import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_enums.dart';
import '../task_list/task_list_provider.dart';

part 'task_provider.g.dart';

@riverpod
Task task(Ref ref, {required String id}) {
  final taskListAsync = ref.watch(taskListProvider);

  return taskListAsync.maybeWhen(
    data: (taskList) {
      if (taskList.isEmpty) {
        return Task(
          id: id,
          notificationId: 0,
          title: '',
          dueDate: DateTime.now(),
          priority: TaskPriority.medium,
          category: TaskCategory.other,
        );
      }

      final task = taskList.firstWhere(
        (task) => task.id == id,
        orElse:
            () => Task(
              id: id,
              notificationId: 0,
              title: '',
              dueDate: DateTime.now(),
              priority: TaskPriority.medium,
              category: TaskCategory.other,
            ),
      );
      return task;
    },
    orElse:
        () => Task(
          id: id,
          notificationId: 0,
          title: '',
          dueDate: DateTime.now(),
          priority: TaskPriority.medium,
          category: TaskCategory.other,
        ),
  );
}


