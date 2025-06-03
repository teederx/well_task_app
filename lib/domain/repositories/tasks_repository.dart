import '../../data/models/task_model/task_model.dart';

abstract class TasksRepository {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask({required TaskModel task});
  Future<void> editTask({
    required String id,
    required String title,
    required String desc,
    required DateTime dueDate,
    required bool alarmSet,
  });
  Future<void> toggleComplete({required String id});
  Future<void> toggleAlarm({required String id});
  Future<void> removeTask({required String id});
}
