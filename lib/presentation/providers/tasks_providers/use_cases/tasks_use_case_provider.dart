import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/presentation/providers/tasks_providers/task_list/task_list_provider.dart';
import '../../../../data/repositories/tasks_repository/provider/tasks_repository_provider.dart';
import '../../../../domain/usecases/tasks/add_task_usecase.dart';
import '../../../../domain/usecases/tasks/edit_task_usecase.dart';
import '../../../../domain/usecases/tasks/get_tasks_usecase.dart';
import '../../../../domain/usecases/tasks/remove_task_usecase.dart';
import '../../../../domain/usecases/tasks/toggle_alarm_usecase.dart';
import '../../../../domain/usecases/tasks/toggle_complete_usecase.dart';

part 'tasks_use_case_provider.g.dart';

@riverpod
GetTasksUsecase getTasksUseCase(GetTasksUseCaseRef ref) {
  return GetTasksUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
AddTaskUsecase addTaskUseCase(AddTaskUseCaseRef ref) {
  return AddTaskUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
EditTaskUsecase editTaskUseCase(EditTaskUseCaseRef ref) {
  return EditTaskUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
RemoveTaskUsecase removeTaskUseCase(RemoveTaskUseCaseRef ref) {
  return RemoveTaskUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
ToggleCompleteUsecase toggleCompleteUseCase(ToggleCompleteUseCaseRef ref) {
  return ToggleCompleteUsecase(ref.watch(tasksRepositoryProvider));
}

@riverpod
ToggleAlarmUsecase toggleAlarmUseCase(ToggleAlarmUseCaseRef ref) {
  return ToggleAlarmUsecase(ref.watch(tasksRepositoryProvider));
}


