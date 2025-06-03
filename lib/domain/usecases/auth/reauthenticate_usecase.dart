import '../../repositories/auth_repository.dart';

class ReauthenticateUsecase {
  final AuthRepository _authRepository;

  ReauthenticateUsecase(this._authRepository);

  Future<void> call({required String email, required String password}) {
    return _authRepository.reauthenticateWithCredential(password: password, email: email);
  }
}