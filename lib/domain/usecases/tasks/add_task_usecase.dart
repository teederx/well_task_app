import 'package:well_task_app/data/models/task_model/task_model.dart';

import '../../repositories/tasks_repository.dart';

class AddTaskUsecase {
  final TasksRepository _taskRepository;

  AddTaskUsecase(this._taskRepository);

  Future<void> call(TaskModel task) async {
    return await _taskRepository.addTask(task: task);
  }
}