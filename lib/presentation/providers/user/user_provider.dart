import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/data/models/app_user/app_user_model.dart';
import 'package:well_task_app/data/repositories/user_repository/provider/user_repository_provider.dart';
import 'package:well_task_app/domain/usecases/user/get_user_usecase.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  FutureOr<AppUserModel> build() {
    return getAppUser();
  }

  Future<AppUserModel> getAppUser() async {
    state = AsyncLoading();

    final userRepo = ref.read(userRepositoryProvider);
    final getUserUsecase = GetUserUsecase(userRepo);

    state = await AsyncValue.guard(() => getUserUsecase.call());

    return state.value!;
  }
}
