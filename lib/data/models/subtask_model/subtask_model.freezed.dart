// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtask_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubtaskModel {

 String get id; String get title; bool get isCompleted; DateTime get createdAt; DateTime? get completedAt;
/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtaskModelCopyWith<SubtaskModel> get copyWith => _$SubtaskModelCopyWithImpl<SubtaskModel>(this as SubtaskModel, _$identity);

  /// Serializes this SubtaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,isCompleted,createdAt,completedAt);

@override
String toString() {
  return 'SubtaskModel(id: $id, title: $title, isCompleted: $isCompleted, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $SubtaskModelCopyWith<$Res>  {
  factory $SubtaskModelCopyWith(SubtaskModel value, $Res Function(SubtaskModel) _then) = _$SubtaskModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, bool isCompleted, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class _$SubtaskModelCopyWithImpl<$Res>
    implements $SubtaskModelCopyWith<$Res> {
  _$SubtaskModelCopyWithImpl(this._self, this._then);

  final SubtaskModel _self;
  final $Res Function(SubtaskModel) _then;

/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? isCompleted = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SubtaskModel implements SubtaskModel {
  const _SubtaskModel({required this.id, required this.title, this.isCompleted = false, required this.createdAt, this.completedAt});
  factory _SubtaskModel.fromJson(Map<String, dynamic> json) => _$SubtaskModelFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  bool isCompleted;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;

/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtaskModelCopyWith<_SubtaskModel> get copyWith => __$SubtaskModelCopyWithImpl<_SubtaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,isCompleted,createdAt,completedAt);

@override
String toString() {
  return 'SubtaskModel(id: $id, title: $title, isCompleted: $isCompleted, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$SubtaskModelCopyWith<$Res> implements $SubtaskModelCopyWith<$Res> {
  factory _$SubtaskModelCopyWith(_SubtaskModel value, $Res Function(_SubtaskModel) _then) = __$SubtaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, bool isCompleted, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class __$SubtaskModelCopyWithImpl<$Res>
    implements _$SubtaskModelCopyWith<$Res> {
  __$SubtaskModelCopyWithImpl(this._self, this._then);

  final _SubtaskModel _self;
  final $Res Function(_SubtaskModel) _then;

/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? isCompleted = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_SubtaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
