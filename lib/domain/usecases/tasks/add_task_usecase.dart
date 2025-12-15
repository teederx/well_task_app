import 'package:fpdart/fpdart.dart' hide Task;
import 'package:well_task_app/core/errors/failure.dart';
import 'package:well_task_app/core/usecase/usecase.dart';
import '../../entities/task.dart';
import '../../repositories/tasks_repository.dart';

class AddTaskUsecase implements UseCase<void, Task> {
  final TasksRepository _taskRepository;

  AddTaskUsecase(this._taskRepository);

  @override
  Future<Either<Failure, void>> call(Task params) async {
    return await _taskRepository.addTask(task: params);
  }
}


