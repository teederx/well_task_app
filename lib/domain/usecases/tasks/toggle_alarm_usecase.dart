import '../../repositories/tasks_repository.dart';

class ToggleAlarmUsecase {
  final TasksRepository _taskRepository;

  ToggleAlarmUsecase(this._taskRepository);

  Future<void> call({required String id}) async {
    return await _taskRepository.toggleAlarm(id: id);
  }
}
