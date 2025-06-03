import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../../domain/usecases/auth/sign_in_usecase.dart';

part 'sign_in_provider.g.dart';

@riverpod
class SignIn extends _$SignIn {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();

    final key = _key;

    final authRepo = ref.read(authRepositoryProvider);
    final signinUseCase = SignInUseCase(authRepo);
    final newState = await AsyncValue.guard(
      () => signinUseCase.call(email: email, password: password),
    );

    if (key == _key) {
      state = newState;
    }
  }
}
