import '../../repositories/auth_repository.dart';

class ReloadUserUsecase {
  final AuthRepository _authRepository;

  ReloadUserUsecase(this._authRepository);

  Future<void> call() {
    return _authRepository.reloadUser();
  }
}


