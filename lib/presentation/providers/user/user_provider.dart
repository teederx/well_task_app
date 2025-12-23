import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/data/models/app_user/app_user_model.dart';
import 'package:well_task_app/data/repositories/user_repository/provider/user_repository_provider.dart';
import 'package:well_task_app/domain/usecases/user/get_user_usecase.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  FutureOr<AppUserModel> build() async {
    final userRepo = ref.watch(userRepositoryProvider);
    final getUserUsecase = GetUserUsecase(userRepo);
    return await getUserUsecase.call();
  }

  // Deprecated: build handles loading now
  Future<AppUserModel> getAppUser() async {
    return await build();
  }
}
