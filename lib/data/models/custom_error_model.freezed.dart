// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_error_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomErrorModel implements DiagnosticableTreeMixin {

 String get code; String get message;
/// Create a copy of CustomErrorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomErrorModelCopyWith<CustomErrorModel> get copyWith => _$CustomErrorModelCopyWithImpl<CustomErrorModel>(this as CustomErrorModel, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CustomErrorModel'))
    ..add(DiagnosticsProperty('code', code))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomErrorModel&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CustomErrorModel(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $CustomErrorModelCopyWith<$Res>  {
  factory $CustomErrorModelCopyWith(CustomErrorModel value, $Res Function(CustomErrorModel) _then) = _$CustomErrorModelCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$CustomErrorModelCopyWithImpl<$Res>
    implements $CustomErrorModelCopyWith<$Res> {
  _$CustomErrorModelCopyWithImpl(this._self, this._then);

  final CustomErrorModel _self;
  final $Res Function(CustomErrorModel) _then;

/// Create a copy of CustomErrorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _CustomErrorModel with DiagnosticableTreeMixin implements CustomErrorModel {
  const _CustomErrorModel({this.code = '', this.message = ''});
  

@override@JsonKey() final  String code;
@override@JsonKey() final  String message;

/// Create a copy of CustomErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomErrorModelCopyWith<_CustomErrorModel> get copyWith => __$CustomErrorModelCopyWithImpl<_CustomErrorModel>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CustomErrorModel'))
    ..add(DiagnosticsProperty('code', code))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomErrorModel&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CustomErrorModel(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CustomErrorModelCopyWith<$Res> implements $CustomErrorModelCopyWith<$Res> {
  factory _$CustomErrorModelCopyWith(_CustomErrorModel value, $Res Function(_CustomErrorModel) _then) = __$CustomErrorModelCopyWithImpl;
@override @useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class __$CustomErrorModelCopyWithImpl<$Res>
    implements _$CustomErrorModelCopyWith<$Res> {
  __$CustomErrorModelCopyWithImpl(this._self, this._then);

  final _CustomErrorModel _self;
  final $Res Function(_CustomErrorModel) _then;

/// Create a copy of CustomErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_CustomErrorModel(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
