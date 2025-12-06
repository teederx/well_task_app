import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../task_list/task_list_provider.dart';

part 'completed_task_list_provider.g.dart';

@riverpod
@riverpod
Future<List<TaskModel>> completedTaskList(Ref ref) async {
  final taskList = await ref.watch(taskListProvider.future);
  return taskList.where((task) => task.isCompleted).toList();
}
