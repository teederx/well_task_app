import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart';
import 'package:well_task_app/data/models/ai_insight_model/ai_insight_model.dart';

class GeminiAIService {
  late final GenerativeModel _model;
  bool _isInitialized = false;

  GeminiAIService() {
    _init();
  }

  void _init() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey != null && apiKey.isNotEmpty) {
      _model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      _isInitialized = true;
    }
  }

  Future<AIInsightModel> generateInsights(List<TaskModel> tasks) async {
    if (!_isInitialized) {
      throw Exception('Gemini API Key is missing.');
    }

    if (tasks.isEmpty) {
      return AIInsightModel(
        productivityScore: 0.0,
        summary: 'No tasks available to analyze.',
        recommendations: ['Add clear tasks to get started.'],
        generatedAt: DateTime.now(),
      );
    }

    final prompt = _buildPrompt(tasks);
    final content = [Content.text(prompt)];

    try {
      final response = await _model.generateContent(content);
      final responseText = response.text;

      if (responseText == null) throw Exception('No response from AI');

      // Clean markdown code blocks if present
      final jsonString =
          responseText.replaceAll('```json', '').replaceAll('```', '').trim();
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      return AIInsightModel.fromJson({
        ...jsonMap,
        'generatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Fallback or rethrow
      throw Exception('Failed to generate insights: $e');
    }
  }

  String _buildPrompt(List<TaskModel> tasks) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln(
      'Analyze the following task list and provide a productivity score (0-100), a short summary, and a list of 3-5 specific recommendations.',
    );
    buffer.writeln('Respond ONLY with valid JSON in the following format:');
    buffer.writeln('''
{
  "productivityScore": 85.0,
  "summary": "You are doing great...",
  "recommendations": ["Focus on...", "Try to..."]
}
''');
    buffer.writeln('Here are the tasks:');

    for (var task in tasks) {
      buffer.writeln(
        '- Task: ${task.title}, Due: ${task.dueDate}, Priority: ${task.priority.name}, Status: ${task.isCompleted ? "Completed" : "Pending"}, Category: ${task.category.label}',
      );
    }

    return buffer.toString();
  }
}
