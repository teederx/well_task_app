import 'package:flutter_test/flutter_test.dart';
import 'package:well_task_app/data/models/ai_insight_model/ai_insight_model.dart';

void main() {
  group('AIInsightModel', () {
    final now = DateTime.now();
    final testInsight = AIInsightModel(
      productivityScore: 85.5,
      summary: 'Great job!',
      recommendations: ['Task A', 'Task B'],
      generatedAt: now,
    );

    test('value equality', () {
      final duplicate = AIInsightModel(
        productivityScore: 85.5,
        summary: 'Great job!',
        recommendations: ['Task A', 'Task B'],
        generatedAt: now,
      );
      expect(testInsight, equals(duplicate));
    });

    test('json serialization', () {
      final json = testInsight.toJson();
      final fromJson = AIInsightModel.fromJson(json);
      expect(fromJson, equals(testInsight));
      expect(fromJson.productivityScore, 85.5);
      expect(fromJson.recommendations.length, 2);
    });
  });
}
