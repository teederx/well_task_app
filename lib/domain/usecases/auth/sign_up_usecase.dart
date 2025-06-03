import '../../repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository _authRepository;

  SignUpUsecase(this._authRepository);

  Future<void> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    return _authRepository.signUp(
      password: password,
      email: email,
      name: name,
      phone: phone,
    );
  }
}
