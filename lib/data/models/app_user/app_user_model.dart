import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

@freezed
abstract class AppUserModel with _$AppUserModel {
  const factory AppUserModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String email,
    @Default('0') String phone,
  }) = _AppUserModel;

  factory AppUserModel.fromJson(Map<String, dynamic> json) => _$AppUserModelFromJson(json);

  factory AppUserModel.fromDoc(DocumentSnapshot appUserDoc) {
    //Fetch data from firebase cloud storage
    final appUserData = appUserDoc.data() as Map<String, dynamic>;

    return AppUserModel(
      id: appUserDoc.id,
      name: appUserData['name'],
      email: appUserData['email'],
      phone: appUserData['phone'],
    );
  }
}

