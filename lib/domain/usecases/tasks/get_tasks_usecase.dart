import 'package:fpdart/fpdart.dart' hide Task;
import 'package:well_task_app/core/errors/failure.dart';
import 'package:well_task_app/core/usecase/usecase.dart';
import '../../entities/task.dart';
import '../../repositories/tasks_repository.dart';

class GetTasksUsecase implements UseCase<List<Task>, NoParams> {
  final TasksRepository _tasksRepository;

  GetTasksUsecase(this._tasksRepository);

  @override
  Future<Either<Failure, List<Task>>> call(NoParams params) async {
    return await _tasksRepository.getTasks();
  }
}


