// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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


/// Adds pattern-matching-related methods to [CustomErrorModel].
extension CustomErrorModelPatterns on CustomErrorModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomErrorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomErrorModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomErrorModel value)  $default,){
final _that = this;
switch (_that) {
case _CustomErrorModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomErrorModel value)?  $default,){
final _that = this;
switch (_that) {
case _CustomErrorModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomErrorModel() when $default != null:
return $default(_that.code,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message)  $default,) {final _that = this;
switch (_that) {
case _CustomErrorModel():
return $default(_that.code,_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _CustomErrorModel() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
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


