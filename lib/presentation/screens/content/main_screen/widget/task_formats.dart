import '../../../../../data/models/task_model/task_model.dart';

List<TaskModel> tasksForDate(DateTime date, List<TaskModel> allTasks) {
  final targetDate = DateTime(date.year, date.month, date.day);

  return allTasks.where((task) {
    final taskDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    return taskDate == targetDate && !task.isCompleted;
  }).toList();
}

List<TaskModel> tasksForToday(List<TaskModel> allTasks) {
  final today = DateTime.now();
  return tasksForDate(today, allTasks);
}

List<TaskModel> tasksAfterToday(List<TaskModel> allTasks) {
  final today = DateTime.now();
  final todayAtMidnight = DateTime(today.year, today.month, today.day);

  return allTasks.where((task) {
    final taskDateAtMidnight = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    return taskDateAtMidnight.isAfter(todayAtMidnight) && !task.isCompleted;
  }).toList();
}

List<TaskModel> getUpcomingTasks(List<TaskModel> allTasks) {
  return tasksAfterToday(allTasks);
}
