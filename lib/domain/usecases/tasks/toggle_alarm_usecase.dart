import 'package:fpdart/fpdart.dart' hide Task;
import 'package:well_task_app/core/errors/failure.dart';
import 'package:well_task_app/core/usecase/usecase.dart';
import '../../repositories/tasks_repository.dart';

class ToggleAlarmUsecase implements UseCase<void, String> {
  final TasksRepository _taskRepository;

  ToggleAlarmUsecase(this._taskRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _taskRepository.toggleAlarm(id: params);
  }
}


