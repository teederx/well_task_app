import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository _authRepository;

  GetCurrentUserUsecase(this._authRepository);

  User? call() {
    return _authRepository.currentUser!;
  }
}

