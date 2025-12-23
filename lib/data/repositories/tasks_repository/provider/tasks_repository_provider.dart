import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/repositories/tasks_repository.dart';
import '../../auth_repository/provider/auth_repository_provider.dart';
import '../tasks_repository_impl.dart';

part 'tasks_repository_provider.g.dart';

@riverpod
TasksRepository tasksRepository(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);
  final user = authState.valueOrNull;

  if (user == null) {
    throw Exception("User not authenticated");
  }

  return TasksRepositoryImpl(userId: user.uid);
}
