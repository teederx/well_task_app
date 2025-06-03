import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/domain/usecases/tasks/get_tasks_usecase.dart';

import '../../../../data/models/task_model/task_model.dart';
import '../../../../data/repositories/tasks_repository/provider/tasks_repository_provider.dart';
import '../../../../domain/usecases/tasks/add_task_usecase.dart';
import '../../../../domain/usecases/tasks/edit_task_usecase.dart';
import '../../../../domain/usecases/tasks/remove_task_usecase.dart';
import '../../../../domain/usecases/tasks/toggle_alarm_usecase.dart';
import '../../../../domain/usecases/tasks/toggle_complete_usecase.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  FutureOr<List<TaskModel>> build() {
    return _getTasks();
  }

  Future<List<TaskModel>> _getTasks() {
    final taskRepo = ref.read(tasksRepositoryProvider);
    final getTasksUsecase = GetTasksUsecase(taskRepo);
    return getTasksUsecase.call();
  }

  Future<void> addTask({
    required String id,
    required int notId,
    required String title,
    required String desc,
    required DateTime dueDate,
    bool alarmSet = false,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newTask = TaskModel.createTask(
        notificationId: notId,
        id: id,
        title: title,
        description: desc,
        dueDate: dueDate,
        alarmSet: alarmSet,
      );

      final taskRepo = ref.read(tasksRepositoryProvider);
      final addTaskUsecase = AddTaskUsecase(taskRepo);

      await addTaskUsecase.call(newTask);

      return [...state.value!, newTask];
    });
  }

  Future<void> editTask({
    required String id,
    required String title,
    required String desc,
    required DateTime dueDate,
    required bool alarmSet,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(tasksRepositoryProvider);
      final editTaskUsecase = EditTaskUsecase(taskRepo);

      await editTaskUsecase.call(
        id: id,
        title: title,
        desc: desc,
        dueDate: dueDate,
        alarmSet: alarmSet,
      );

      return [
        for (final task in state.value!)
          if (task.id == id)
            task.copyWith(
              title: title,
              description: desc,
              dueDate: dueDate,
              alarmSet: alarmSet,
            )
          else
            task,
      ];
    });
  }

  Future<void> toggleComplete(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(tasksRepositoryProvider);
      final toggleTaskUsecase = ToggleCompleteUsecase(taskRepo);

      await toggleTaskUsecase.call(id: id);

      return [
        for (final task in state.value!)
          if (task.id == id)
            task.copyWith(isCompleted: !task.isCompleted)
          else
            task,
      ];
    });
  }

  Future<void> toggleAlarm(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(tasksRepositoryProvider);
      final toggleAlarmUsecase = ToggleAlarmUsecase(taskRepo);

      await toggleAlarmUsecase.call(id: id);

      return [
        for (final task in state.value!)
          if (task.id == id) task.copyWith(alarmSet: !task.alarmSet) else task,
      ];
    });
  }

  Future<void> removeTask(String id) async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      final taskRepo = ref.read(tasksRepositoryProvider);
      final removeTaskUsecase = RemoveTaskUsecase(taskRepo);

      await removeTaskUsecase.call(id: id);

      return [
        for (final task in state.value!)
          if (task.id != id) task,
      ];
    });
  }
}

// final List<TaskModel> allTasks = [
//   TaskModel(
//     id: '1',
//     notificationId: 1,
//     title: 'Task 1',
//     description: 'Description 1',
//     dueDate: DateTime.now(), // today
//   ),
//   TaskModel(
//     id: '2',
//     notificationId: 2,
//     title: 'Task 2',
//     description: 'Description 2',
//     dueDate: DateTime.now().add(const Duration(days: 1)), // tomorrow
//     alarmSet: true,
//   ),
//   TaskModel(
//     id: '3',
//     notificationId: 3,
//     title: 'Task 3',
//     description: 'Description 3',
//     dueDate: DateTime.now().add(Duration(hours: 1)), // today
//     alarmSet: true,
//   ),
//   TaskModel(
//     id: '4',
//     notificationId: 4,
//     title: 'Task 4',
//     description: 'Description 2',
//     dueDate: DateTime.now().add(const Duration(days: 2)), // tomorrow
//     alarmSet: true,
//   ),
//   TaskModel(
//     id: '5',
//     notificationId: 5,
//     title: 'Task 5',
//     description: 'Description 2',
//     dueDate: DateTime.now().add(const Duration(days: 3)), // tomorrow
//   ),
//   // Add more tasks...
// ];
