import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/data/models/subtask_model/subtask_model.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart'; // For SubtaskList if needed, but model is separate

void main() {
  group('SubtaskModel', () {
    final now = DateTime.now();
    final testSubtask = SubtaskModel(
      id: 'sub-1',
      title: 'Subtask 1',
      createdAt: now,
    );

    test('should have correct default values', () {
      expect(testSubtask.isCompleted, false);
      expect(testSubtask.completedAt, null);
    });

    test('serialization', () {
      final json = testSubtask.toJson();
      final fromJson = SubtaskModel.fromJson(json);
      expect(fromJson, equals(testSubtask));
    });

    test('copyWith', () {
      final completed = testSubtask.copyWith(
        isCompleted: true,
        completedAt: now,
      );
      expect(completed.isCompleted, true);
      expect(completed.completedAt, now);
    });
  });
}
