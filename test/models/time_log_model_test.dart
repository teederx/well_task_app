import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/data/models/time_log_model/time_log_model.dart';

void main() {
  group('TimeLogModel', () {
    final now = DateTime.now();
    final testLog = TimeLogModel(id: 'log-1', startTime: now);

    test('should have correct default values', () {
      expect(testLog.duration, 0);
      expect(testLog.endTime, null);
      expect(testLog.note, null);
    });

    test('serialization', () {
      final json = testLog.toJson();
      // Dealing with slight millisecond differences in JSON serialization if not handled can be annoying
      // but Freeze usually handles it well.
      final fromJson = TimeLogModel.fromJson(json);
      expect(fromJson, equals(testLog));
    });
  });
}

