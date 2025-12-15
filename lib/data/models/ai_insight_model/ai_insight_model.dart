import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_insight_model.freezed.dart';
part 'ai_insight_model.g.dart';

@freezed
abstract class AIInsightModel with _$AIInsightModel {
  const factory AIInsightModel({
    required double productivityScore,
    required String summary,
    required List<String> recommendations,
    required DateTime generatedAt,
  }) = _AIInsightModel;

  factory AIInsightModel.fromJson(Map<String, dynamic> json) =>
      _$AIInsightModelFromJson(json);
}


