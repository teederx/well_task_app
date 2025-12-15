import '../../repositories/auth_repository.dart';

class SendPasswordResetUsecase {
  final AuthRepository _authRepository;

  SendPasswordResetUsecase(this._authRepository);

  Future<void> call({required String email}) {
    return _authRepository.sendPasswordResetEmail(email: email);
  }
}

