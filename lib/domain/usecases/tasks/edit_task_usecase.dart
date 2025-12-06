import 'package:well_task_app/data/models/subtask_model/subtask_model.dart';

import '../../../data/models/task_model/task_model.dart';
import '../../../data/models/task_model/task_enums.dart';
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
    required bool remind5MinEarly,
    required TaskPriority priority,
    TaskCategory category = TaskCategory.other,
    List<String> tags = const [],
    RecurringType recurringType = RecurringType.none,
    int recurringInterval = 1,
    List<SubtaskModel> subtasks = const [],
  }) async {
    return await _taskRepository.editTask(
      id: id,
      title: title,
      desc: desc,
      dueDate: dueDate,
      alarmSet: alarmSet,
      remind5MinEarly: remind5MinEarly,
      priority: priority,
      category: category,
      tags: tags,
      recurringType: recurringType,
      recurringInterval: recurringInterval,
      subtasks: subtasks,
    );
  }
}
