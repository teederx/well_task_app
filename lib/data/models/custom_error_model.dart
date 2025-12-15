import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_error_model.freezed.dart';

@freezed
abstract class CustomErrorModel with _$CustomErrorModel{
  const factory CustomErrorModel({
    @Default('') String code,
    @Default('') String message,
  }) = _CustomErrorModel;
}

