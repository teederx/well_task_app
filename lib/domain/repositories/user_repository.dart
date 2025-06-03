import '../../data/models/app_user/app_user_model.dart';

abstract class UserRepository {
  Future<AppUserModel> getUser();
}