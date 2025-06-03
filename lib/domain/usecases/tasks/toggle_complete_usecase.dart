import '../../repositories/tasks_repository.dart';

class ToggleCompleteUsecase {
  final TasksRepository _taskRepository;

  ToggleCompleteUsecase(this._taskRepository);

  Future<void> call({required String id}) async {
    return await _taskRepository.toggleComplete(id: id);
  }
}
