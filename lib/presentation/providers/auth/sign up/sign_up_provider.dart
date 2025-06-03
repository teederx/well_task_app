import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../../domain/usecases/auth/sign_up_usecase.dart';

part 'sign_up_provider.g.dart';

@riverpod
class SignUp extends _$SignUp {
  Object? _key;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      // print('[signupProvider] disposed');
      _key = null;
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    state = const AsyncLoading();

    final key = _key;

    final authRepo = ref.read(authRepositoryProvider);
    final signUpUseCase = SignUpUsecase(authRepo);

    final newState = await AsyncValue.guard(() {
      return signUpUseCase.call(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
    });

    if (key == _key) {
      state = newState;
    }
  }
}
