import 'package:well_task_app/data/models/app_user/app_user_model.dart';

import '../../repositories/user_repository.dart';

class GetUserUsecase {
  final UserRepository _userRepository;

  GetUserUsecase(this._userRepository);

  Future<AppUserModel> call() async {
    return await _userRepository.getUser();
  }
}


