// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_insight_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AIInsightModel {

 double get productivityScore; String get summary; List<String> get recommendations; DateTime get generatedAt;
/// Create a copy of AIInsightModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AIInsightModelCopyWith<AIInsightModel> get copyWith => _$AIInsightModelCopyWithImpl<AIInsightModel>(this as AIInsightModel, _$identity);

  /// Serializes this AIInsightModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AIInsightModel&&(identical(other.productivityScore, productivityScore) || other.productivityScore == productivityScore)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.recommendations, recommendations)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productivityScore,summary,const DeepCollectionEquality().hash(recommendations),generatedAt);

@override
String toString() {
  return 'AIInsightModel(productivityScore: $productivityScore, summary: $summary, recommendations: $recommendations, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class $AIInsightModelCopyWith<$Res>  {
  factory $AIInsightModelCopyWith(AIInsightModel value, $Res Function(AIInsightModel) _then) = _$AIInsightModelCopyWithImpl;
@useResult
$Res call({
 double productivityScore, String summary, List<String> recommendations, DateTime generatedAt
});




}
/// @nodoc
class _$AIInsightModelCopyWithImpl<$Res>
    implements $AIInsightModelCopyWith<$Res> {
  _$AIInsightModelCopyWithImpl(this._self, this._then);

  final AIInsightModel _self;
  final $Res Function(AIInsightModel) _then;

/// Create a copy of AIInsightModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productivityScore = null,Object? summary = null,Object? recommendations = null,Object? generatedAt = null,}) {
  return _then(_self.copyWith(
productivityScore: null == productivityScore ? _self.productivityScore : productivityScore // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,recommendations: null == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AIInsightModel implements AIInsightModel {
  const _AIInsightModel({required this.productivityScore, required this.summary, required final  List<String> recommendations, required this.generatedAt}): _recommendations = recommendations;
  factory _AIInsightModel.fromJson(Map<String, dynamic> json) => _$AIInsightModelFromJson(json);

@override final  double productivityScore;
@override final  String summary;
 final  List<String> _recommendations;
@override List<String> get recommendations {
  if (_recommendations is EqualUnmodifiableListView) return _recommendations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendations);
}

@override final  DateTime generatedAt;

/// Create a copy of AIInsightModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AIInsightModelCopyWith<_AIInsightModel> get copyWith => __$AIInsightModelCopyWithImpl<_AIInsightModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AIInsightModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AIInsightModel&&(identical(other.productivityScore, productivityScore) || other.productivityScore == productivityScore)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._recommendations, _recommendations)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productivityScore,summary,const DeepCollectionEquality().hash(_recommendations),generatedAt);

@override
String toString() {
  return 'AIInsightModel(productivityScore: $productivityScore, summary: $summary, recommendations: $recommendations, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$AIInsightModelCopyWith<$Res> implements $AIInsightModelCopyWith<$Res> {
  factory _$AIInsightModelCopyWith(_AIInsightModel value, $Res Function(_AIInsightModel) _then) = __$AIInsightModelCopyWithImpl;
@override @useResult
$Res call({
 double productivityScore, String summary, List<String> recommendations, DateTime generatedAt
});




}
/// @nodoc
class __$AIInsightModelCopyWithImpl<$Res>
    implements _$AIInsightModelCopyWith<$Res> {
  __$AIInsightModelCopyWithImpl(this._self, this._then);

  final _AIInsightModel _self;
  final $Res Function(_AIInsightModel) _then;

/// Create a copy of AIInsightModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productivityScore = null,Object? summary = null,Object? recommendations = null,Object? generatedAt = null,}) {
  return _then(_AIInsightModel(
productivityScore: null == productivityScore ? _self.productivityScore : productivityScore // ignore: cast_nullable_to_non_nullable
as double,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,recommendations: null == recommendations ? _self._recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as List<String>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
