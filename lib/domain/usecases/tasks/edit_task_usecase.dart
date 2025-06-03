import '../../repositories/tasks_repository.dart';

class EditTaskUsecase {
  final TasksRepository _taskRepository;

  EditTaskUsecase(this._taskRepository);

  Future<void> call({
    required String id,
    required String title,
    required String desc,
    required DateTime dueDate,
    required bool alarmSet,
  }) async {
    return await _taskRepository.editTask(
      id: id,
      title: title,
      desc: desc,
      dueDate: dueDate,
      alarmSet: alarmSet,
    );
  }
}
