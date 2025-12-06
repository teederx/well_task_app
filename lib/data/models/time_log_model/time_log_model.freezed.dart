// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeLogModel {

 String get id; DateTime get startTime; DateTime? get endTime; int get duration;// duration in seconds
 String? get note;
/// Create a copy of TimeLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeLogModelCopyWith<TimeLogModel> get copyWith => _$TimeLogModelCopyWithImpl<TimeLogModel>(this as TimeLogModel, _$identity);

  /// Serializes this TimeLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,duration,note);

@override
String toString() {
  return 'TimeLogModel(id: $id, startTime: $startTime, endTime: $endTime, duration: $duration, note: $note)';
}


}

/// @nodoc
abstract mixin class $TimeLogModelCopyWith<$Res>  {
  factory $TimeLogModelCopyWith(TimeLogModel value, $Res Function(TimeLogModel) _then) = _$TimeLogModelCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startTime, DateTime? endTime, int duration, String? note
});




}
/// @nodoc
class _$TimeLogModelCopyWithImpl<$Res>
    implements $TimeLogModelCopyWith<$Res> {
  _$TimeLogModelCopyWithImpl(this._self, this._then);

  final TimeLogModel _self;
  final $Res Function(TimeLogModel) _then;

/// Create a copy of TimeLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? endTime = freezed,Object? duration = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TimeLogModel implements TimeLogModel {
  const _TimeLogModel({required this.id, required this.startTime, this.endTime, this.duration = 0, this.note});
  factory _TimeLogModel.fromJson(Map<String, dynamic> json) => _$TimeLogModelFromJson(json);

@override final  String id;
@override final  DateTime startTime;
@override final  DateTime? endTime;
@override@JsonKey() final  int duration;
// duration in seconds
@override final  String? note;

/// Create a copy of TimeLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeLogModelCopyWith<_TimeLogModel> get copyWith => __$TimeLogModelCopyWithImpl<_TimeLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,duration,note);

@override
String toString() {
  return 'TimeLogModel(id: $id, startTime: $startTime, endTime: $endTime, duration: $duration, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TimeLogModelCopyWith<$Res> implements $TimeLogModelCopyWith<$Res> {
  factory _$TimeLogModelCopyWith(_TimeLogModel value, $Res Function(_TimeLogModel) _then) = __$TimeLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startTime, DateTime? endTime, int duration, String? note
});




}
/// @nodoc
class __$TimeLogModelCopyWithImpl<$Res>
    implements _$TimeLogModelCopyWith<$Res> {
  __$TimeLogModelCopyWithImpl(this._self, this._then);

  final _TimeLogModel _self;
  final $Res Function(_TimeLogModel) _then;

/// Create a copy of TimeLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = freezed,Object? duration = null,Object? note = freezed,}) {
  return _then(_TimeLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
