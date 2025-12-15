// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_insight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AIInsightModel _$AIInsightModelFromJson(Map<String, dynamic> json) =>
    _AIInsightModel(
      productivityScore: (json['productivityScore'] as num).toDouble(),
      summary: json['summary'] as String,
      recommendations:
          (json['recommendations'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$AIInsightModelToJson(_AIInsightModel instance) =>
    <String, dynamic>{
      'productivityScore': instance.productivityScore,
      'summary': instance.summary,
      'recommendations': instance.recommendations,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };


