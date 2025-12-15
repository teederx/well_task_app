import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/data/services/gemini_ai_service.dart';
import 'package:well_task_app/data/models/ai_insight_model/ai_insight_model.dart';
import 'package:well_task_app/presentation/providers/tasks_providers/task_list/task_list_provider.dart';

part 'ai_insights_provider.g.dart';

@riverpod
class AiInsights extends _$AiInsights {
  late final GeminiAIService _geminiService;

  @override
  Future<AIInsightModel?> build() async {
    _geminiService = GeminiAIService();
    return null; // Return null initially instead of a string
  }

  Future<void> generateInsights() async {
    state = const AsyncValue.loading();

    try {
      final tasks = await ref.read(taskListProvider.future);
      final insights = await _geminiService.generateInsights(tasks);
      state = AsyncValue.data(insights);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}


