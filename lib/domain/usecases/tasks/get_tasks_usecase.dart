import 'package:well_task_app/domain/repositories/tasks_repository.dart';

import '../../../data/models/task_model/task_model.dart';

class GetTasksUsecase {
  final TasksRepository _tasksRepository;

  GetTasksUsecase(this._tasksRepository);

  Future<List<TaskModel>> call() async {
    try {
      return await _tasksRepository.getTasks();
    } catch (e) {
      // You can also throw a domain-specific error here
      rethrow;
    }
  }
}

