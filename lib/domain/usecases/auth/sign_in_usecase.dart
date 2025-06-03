import '../../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<void> call({required String email, required String password}) {
    return _authRepository.signIn(email: email, password: password);
  }
}
