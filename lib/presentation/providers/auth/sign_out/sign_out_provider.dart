import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../../domain/usecases/auth/sign_out_usecase.dart';

part 'sign_out_provider.g.dart';

@riverpod
class SignOut extends _$SignOut {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();

    final key = _key;

    final authRepo = ref.read(authRepositoryProvider);
    final signOutUseCase = SignOutUsecase(authRepo);

    final newState = await AsyncValue.guard(() => signOutUseCase.call());
    if (key == _key) {
      state = newState;
    }
  }
}
