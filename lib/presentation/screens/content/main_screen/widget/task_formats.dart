import '../../../../../domain/entities/task.dart';

List<Task> tasksForDate(DateTime date, List<Task> allTasks) {
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

List<Task> tasksForToday(List<Task> allTasks) {
  final today = DateTime.now();
  return tasksForDate(today, allTasks);
}

List<Task> tasksAfterToday(List<Task> allTasks) {
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

List<Task> getUpcomingTasks(List<Task> allTasks) {
  return tasksAfterToday(allTasks);
}


