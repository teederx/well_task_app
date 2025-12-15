import '../../repositories/auth_repository.dart';

class ChangePasswordUsecase {
  final AuthRepository _authRepository;

  ChangePasswordUsecase(this._authRepository);

  Future<void> call({required String password}) {
    return _authRepository.changePassword(password: password);
  }
}

