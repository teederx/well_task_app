import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/task.dart';
import '../task_list/task_list_provider.dart';

part 'completed_task_list_provider.g.dart';

@riverpod
Future<List<Task>> completedTaskList(Ref ref) async {
  final taskList = await ref.watch(taskListProvider.future);
  return taskList.where((task) => task.isCompleted).toList();
}


