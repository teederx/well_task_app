import '../../repositories/tasks_repository.dart';

class RemoveTaskUsecase {
  final TasksRepository _taskRepository;

  RemoveTaskUsecase(this._taskRepository);

  Future<void> call({required String id}) async {
    return await _taskRepository.removeTask(id: id);
  }
}
