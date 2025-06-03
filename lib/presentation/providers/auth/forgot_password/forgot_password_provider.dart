import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/auth_repository/provider/auth_repository_provider.dart';
import '../../../../domain/usecases/auth/send_password_reset_usecase.dart';

part 'forgot_password_provider.g.dart';

@riverpod
class ForgotPassword extends _$ForgotPassword {
  Object? _key;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() {
      _key = null;
    });
  }

  Future<void> forgotPassword ({required String email}) async{
    state = const AsyncLoading();

    final key = _key;
    
    final authRepo = ref.read(authRepositoryProvider);
    final sendPasswordResetUseCase = SendPasswordResetUsecase(authRepo);

    final newState = await AsyncValue.guard(() async {
      // Send password reset email
      await sendPasswordResetUseCase(email: email);
    });

    if (key == _key) {
      state = newState;
    }
  }
}