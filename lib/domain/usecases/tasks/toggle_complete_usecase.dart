import 'package:fpdart/fpdart.dart' hide Task;
import 'package:well_task_app/core/errors/failure.dart';
import 'package:well_task_app/core/usecase/usecase.dart';
import '../../repositories/tasks_repository.dart';

class ToggleCompleteUsecase implements UseCase<void, String> {
  final TasksRepository _taskRepository;

  ToggleCompleteUsecase(this._taskRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _taskRepository.toggleComplete(id: params);
  }
}


