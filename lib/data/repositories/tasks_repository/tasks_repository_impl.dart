import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/repositories/tasks_repository.dart';
import '../../../utils/constants/firebase_constants.dart';
import '../../models/task_model/task_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  Future<Box> get _taskBox async {
    final userId = fbAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not authenticated");
    if (!Hive.isBoxOpen('Tasks_$userId')) {
      await Hive.openBox('Tasks_$userId');
    }
    return Hive.box('Tasks_$userId');
  }

  @override
  Future<void> addTask({required TaskModel task}) async {
    final box = await _taskBox;
    await box.put(task.id, task.toJson());
  }

  @override
  Future<void> editTask({
    required String id,
    required String title,
    required String desc,
    required DateTime dueDate,
    required bool alarmSet,
  }) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      taskMap['description'] = desc;
      taskMap['title'] = title;
      taskMap['dueDate'] = dueDate;
      taskMap['alarmSet'] = alarmSet;
      await box.put(id, taskMap);
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final box = await _taskBox;
    return box.values
        .map((e) => TaskModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> removeTask({required String id}) async {
    final box = await _taskBox;
    await box.delete(id);
  }

  @override
  Future<void> toggleComplete({required String id}) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      taskMap['isCompleted'] = !taskMap['isCompleted'];
      await box.put(id, taskMap);
    }
  }

  @override
  Future<void> toggleAlarm({required String id}) async {
    final box = await _taskBox;
    final taskMap = box.get(id);
    if (taskMap != null) {
      taskMap['alarmSet'] = !taskMap['alarmSet'];
      await box.put(id, taskMap);
    }
  }
}
