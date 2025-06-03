import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:well_task_app/data/repositories/auth_repository/auth_repository_impl.dart';

import '../../../../utils/constants/firebase_constants.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepositoryImpl authRepository(Ref ref) {
  return AuthRepositoryImpl();
}

@riverpod
Stream<User?> authStateStream(Ref ref) {
  return fbAuth.authStateChanges();
}
