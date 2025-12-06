import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart';
import 'package:well_task_app/data/models/task_model/task_enums.dart';

void main() {
  group('TaskModel', () {
    final now = DateTime.now();
    final testTask = TaskModel(
      id: '123',
      notificationId: 1,
      title: 'Test Task',
      description: 'Test Description',
      dueDate: now,
    );

    test('should support value equality', () {
      final task1 = TaskModel(
        id: '1',
        notificationId: 1,
        title: 'Task',
        description: 'Desc',
        dueDate: now,
      );
      final task2 = TaskModel(
        id: '1',
        notificationId: 1,
        title: 'Task',
        description: 'Desc',
        dueDate: now,
      );

      expect(task1, equals(task2));
    });

    test('should have correct default values', () {
      expect(testTask.isCompleted, false);
      expect(testTask.priority, TaskPriority.medium); // Default is medium
      expect(testTask.category, TaskCategory.other);
      expect(testTask.tags, isEmpty);
      expect(testTask.subtasks, isEmpty);
      expect(testTask.timeLogs, isEmpty);
      expect(testTask.attachments, isEmpty);
      expect(testTask.isTimerRunning, false);
      expect(testTask.totalTimeSpent, 0);
    });

    test('should serialize and deserialize correctly (fromJson/toJson)', () {
      final json = testTask.toJson();
      final fromJson = TaskModel.fromJson(json);

      expect(fromJson, equals(testTask));
      expect(fromJson.id, '123');
      expect(fromJson.title, 'Test Task');
    });

    test('copyWith should return a new instance with updated values', () {
      final updatedTask = testTask.copyWith(
        title: 'Updated Title',
        isCompleted: true,
      );

      expect(updatedTask.id, testTask.id);
      expect(updatedTask.title, 'Updated Title');
      expect(updatedTask.isCompleted, true);
      expect(testTask.title, 'Test Task'); // Original unchanged
    });
  });
}
