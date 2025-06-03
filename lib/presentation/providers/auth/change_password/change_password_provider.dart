import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../../domain/usecases/auth/change_password_usecase.dart';
import '../../../../domain/usecases/auth/reauthenticate_usecase.dart';
import '../../../../domain/usecases/auth/sign_out_usecase.dart';

part 'change_password_provider.g.dart';

@riverpod
class ChangePassword extends _$ChangePassword {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const AsyncLoading();

    final key = _key;

    final authRepo = ref.read(authRepositoryProvider);
    final reauthenticateUseCase = ReauthenticateUsecase(authRepo);
    final changePasswordUseCase = ChangePasswordUsecase(authRepo);
    final signOutUsecase = SignOutUsecase(authRepo);

    final newState = await AsyncValue.guard(() async {
      // Reauthenticate the user with the current password
      // This is necessary to change the password
      await reauthenticateUseCase.call(email: email, password: currentPassword);
      // Change the password to the new one
      await changePasswordUseCase.call(password: newPassword);

      // Sign out the user after changing the password
      await signOutUsecase.call();
    });

    if (key == _key) {
      state = newState;
    }
  }
}
