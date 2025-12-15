import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/tasks_repository/provider/tasks_repository_provider.dart';
import '../../../../domain/usecases/tasks/add_task_usecase.dart';
import '../../../../domain/usecases/tasks/edit_task_usecase.dart';
import '../../../../domain/usecases/tasks/get_tasks_usecase.dart';
import '../../../../domain/usecases/tasks/remove_task_usecase.dart';
import '../../../../domain/usecases/tasks/toggle_alarm_usecase.dart';
import '../../../../domain/usecases/tasks/toggle_complete_usecase.dart';

part 'tasks_use_case_provider.g.dart';

@riverpod
GetTasksUsecase getTasksUseCase(Ref ref) {
  return GetTasksUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
AddTaskUsecase addTaskUseCase(Ref ref) {
  return AddTaskUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
EditTaskUsecase editTaskUseCase(Ref ref) {
  return EditTaskUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
RemoveTaskUsecase removeTaskUseCase(Ref ref) {
  return RemoveTaskUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
ToggleCompleteUsecase toggleCompleteUseCase(Ref ref) {
  return ToggleCompleteUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
ToggleAlarmUsecase toggleAlarmUseCase(Ref ref) {
  return ToggleAlarmUsecase(ref.watch(tasksRepositoryProvider));
}
