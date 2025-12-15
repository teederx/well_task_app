import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:well_task_app/core/errors/failure.dart';

import 'package:well_task_app/domain/entities/task.dart';
import 'package:well_task_app/domain/entities/task_enums.dart';

// Use Cases
import 'package:well_task_app/domain/usecases/tasks/get_tasks_usecase.dart';
import 'package:well_task_app/domain/usecases/tasks/add_task_usecase.dart';
import 'package:well_task_app/domain/usecases/tasks/edit_task_usecase.dart';
import 'package:well_task_app/domain/usecases/tasks/remove_task_usecase.dart';
import 'package:well_task_app/domain/usecases/tasks/toggle_complete_usecase.dart';
import 'package:well_task_app/domain/usecases/tasks/toggle_alarm_usecase.dart';

// Providers
import 'package:well_task_app/presentation/providers/tasks_providers/use_cases/tasks_use_case_provider.dart';
import 'package:well_task_app/presentation/providers/tasks_providers/task_list/task_list_provider.dart';

import 'task_list_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetTasksUsecase>(),
  MockSpec<AddTaskUsecase>(),
  MockSpec<EditTaskUsecase>(),
  MockSpec<RemoveTaskUsecase>(),
  MockSpec<ToggleCompleteUsecase>(),
  MockSpec<ToggleAlarmUsecase>(),
])
void main() {
  late MockGetTasksUsecase mockGetTasksUsecase;
  late MockAddTaskUsecase mockAddTaskUsecase;
  late MockEditTaskUsecase mockEditTaskUsecase;
  late MockRemoveTaskUsecase mockRemoveTaskUsecase;
  late MockToggleCompleteUsecase mockToggleCompleteUsecase;
  late MockToggleAlarmUsecase mockToggleAlarmUsecase;

  late ProviderContainer container;

  setUp(() {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, List<Task>>>(const Right([]));

    mockGetTasksUsecase = MockGetTasksUsecase();
    mockAddTaskUsecase = MockAddTaskUsecase();
    mockEditTaskUsecase = MockEditTaskUsecase();
    mockRemoveTaskUsecase = MockRemoveTaskUsecase();
    mockToggleCompleteUsecase = MockToggleCompleteUsecase();
    mockToggleAlarmUsecase = MockToggleAlarmUsecase();

    container = ProviderContainer(
      overrides: [
        getTasksUseCaseProvider.overrideWith((ref) => mockGetTasksUsecase),
        addTaskUseCaseProvider.overrideWith((ref) => mockAddTaskUsecase),
        editTaskUseCaseProvider.overrideWith((ref) => mockEditTaskUsecase),
        removeTaskUseCaseProvider.overrideWith((ref) => mockRemoveTaskUsecase),
        toggleCompleteUseCaseProvider.overrideWith(
          (ref) => mockToggleCompleteUsecase,
        ),
        toggleAlarmUseCaseProvider.overrideWith(
          (ref) => mockToggleAlarmUsecase,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  final testTask = Task(
    id: '1',
    notificationId: 1,
    title: 'Test Task',
    description: 'Description',
    dueDate: DateTime.now(),
    alarmSet: true,
    remind5MinEarly: false,
    priority: TaskPriority.high,
    category: TaskCategory.work,
    recurringType: RecurringType.none,
  );

  group('TaskListProvider', () {
    test('build returns list of tasks from GetTasksUsecase', () async {
      when(mockGetTasksUsecase(any)).thenAnswer((_) async => Right([testTask]));

      final result = await container.read(taskListProvider.future);

      expect(result, [testTask]);
      verify(mockGetTasksUsecase(any)).called(1);
    });

    test('build returns empty list on Failure', () async {
      when(
        mockGetTasksUsecase(any),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      final result = await container.read(taskListProvider.future);

      expect(result, []);
      verify(mockGetTasksUsecase(any)).called(1);
    });

    test('addTask calls AddTaskUsecase and refreshes', () async {
      when(
        mockAddTaskUsecase(any),
      ) // Ensure matcher is generic enough or matches structure
      .thenAnswer((_) async => const Right(null));

      // Need to mock getTasks for the refresh
      when(mockGetTasksUsecase(any)).thenAnswer((_) async => Right([testTask]));

      await container
          .read(taskListProvider.notifier)
          .addTask(
            notId: 1,
            title: 'Title',
            desc: 'Desc',
            dueDate: DateTime.now(),
            alarmSet: false,
            remind5MinEarly: false,
            priority: TaskPriority.low,
          );

      verify(mockAddTaskUsecase(any)).called(1);
    });

    test('removeTask calls RemoveTaskUsecase and refreshes', () async {
      when(
        mockRemoveTaskUsecase(any),
      ).thenAnswer((_) async => const Right(null));

      when(mockGetTasksUsecase(any)).thenAnswer((_) async => Right([]));

      await container.read(taskListProvider.notifier).removeTask(id: '1');

      verify(mockRemoveTaskUsecase('1')).called(1);
    });

    test('toggleComplete calls ToggleCompleteUsecase and refreshes', () async {
      when(
        mockToggleCompleteUsecase(any),
      ).thenAnswer((_) async => const Right(null));

      when(mockGetTasksUsecase(any)).thenAnswer((_) async => Right([]));

      await container.read(taskListProvider.notifier).toggleComplete(id: '1');

      verify(mockToggleCompleteUsecase('1')).called(1);
    });
  });
}

