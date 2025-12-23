import 'package:hive_flutter/hive_flutter.dart';
import 'package:well_task_app/core/utils/constants/firebase_constants.dart';
import 'package:well_task_app/data/models/app_user/app_user_model.dart';
import 'package:well_task_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final String userId;

  UserRepositoryImpl({required this.userId});

  Future<Box> get _userBox async {
    if (!Hive.isBoxOpen('User_$userId')) {
      await Hive.openBox('User_$userId');
    }
    return Hive.box('User_$userId');
  }

  @override
  Future<AppUserModel> getUser() async {
    try {
      final box = await _userBox;
      var userMap = box.get('details');

      if (userMap == null) {
        // Fallback to Firestore if Hive is empty
        final doc = await usersCollection.doc(userId).get();
        if (doc.exists) {
          final userModel = AppUserModel.fromDoc(doc);
          await box.put('details', userModel.toJson());
          return userModel;
        }
        throw Exception('No user found in Firestore or Box');
      }

      return AppUserModel.fromJson(Map<String, dynamic>.from(userMap));
    } catch (e) {
      rethrow;
    }
  }
}
