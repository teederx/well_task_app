import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/repositories/user_repository.dart';
import '../../auth_repository/provider/auth_repository_provider.dart';
import '../user_repository_impl.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);
  final user = authState.valueOrNull;

  if (user == null) {
    throw Exception("User not authenticated");
  }

  return UserRepositoryImpl(userId: user.uid);
}
