import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/repositories/tasks_repository.dart';
import '../tasks_repository_impl.dart';

part 'tasks_repository_provider.g.dart';

@riverpod
TasksRepository tasksRepository(Ref ref) {
  return TasksRepositoryImpl();
}

