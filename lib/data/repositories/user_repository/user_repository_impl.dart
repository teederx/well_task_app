import 'package:hive_flutter/hive_flutter.dart';
import 'package:well_task_app/data/models/app_user/app_user_model.dart';
import 'package:well_task_app/domain/repositories/user_repository.dart';

import '../../../utils/constants/firebase_constants.dart';

class UserRepositoryImpl implements UserRepository {
  Future<Box> get _userBox async {
    final userId = fbAuth.currentUser?.uid;
    if (userId == null) throw Exception("User not authenticated");
    if (!Hive.isBoxOpen('User_$userId')) {
      await Hive.openBox('User_$userId');
    }
    return Hive.box('User_$userId');
  }

  @override
  Future<AppUserModel> getUser() async {
    try {
      final box = await _userBox;
      final userMap = box.get('details');
      if (userMap == null) {
        throw Exception('No user found in box');
      }
      return AppUserModel.fromJson(Map<String, dynamic>.from(userMap));
    } catch (e) {
      rethrow;
    }
  }
}
