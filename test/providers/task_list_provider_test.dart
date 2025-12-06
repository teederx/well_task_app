
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:well_task_app/data/models/task_model/task_enums.dart';
import 'package:well_task_app/data/models/task_model/task_model.dart';
import 'package:well_task_app/data/repositories/tasks_repository/provider/tasks_repository_provider.dart';
import 'package:well_task_app/domain/repositories/tasks_repository.dart';
import 'package:well_task_app/presentation/providers/tasks_providers/task_list/task_list_provider.dart';

class MockTasksRepository extends Mock implements TasksRepository {}

class FakeTaskModel extends Fake implements TaskModel {}

void main() {
  late MockTasksRepository mockRepository;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(FakeTaskModel());
    registerFallbackValue(TaskCategory.other);
    registerFallbackValue(TaskPriority.medium);
    registerFallbackValue(RecurringType.none);
  });

  setUp(() {
    mockRepository = MockTasksRepository();
    container = ProviderContainer(
      overrides: [
        tasksRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('TaskListProvider', () {
    test('initial state is list of tasks from repository', () async {
      // Arrange
      final tasks = [
        TaskModel(
          id: '1',
          notificationId: 1,
          title: 'Task 1',
          dueDate: DateTime.now(),
        ),
      ];
      when(() => mockRepository.getTasks()).thenAnswer((_) async => tasks);

      // Act
      final listener = container.listen(
        taskListProvider,
        (previous, next) {},
        fireImmediately: true,
      );
      
      // Wait for the provider to initialize (it's async)
       await container.read(taskListProvider.future);

      // Assert
      expect(listener.read().value, tasks);
      verify(() => mockRepository.getTasks()).called(1);
    });

    test('addTask calls repository', () async {
      // Arrange
      when(() => mockRepository.getTasks()).thenAnswer((_) async => []);
      when(() => mockRepository.addTask(task: any(named: 'task')))
          .thenAnswer((_) async {});

      // Act
      await container.read(taskListProvider.notifier).addTask(
            id: '1',
            notId: 1,
            title: 'New Task',
            desc: '',
            dueDate: DateTime.now(),
            alarmSet: false,
            remind5MinEarly: false,
            priority: TaskPriority.medium,
          );

      // Assert
      verify(() => mockRepository.addTask(task: any(named: 'task'))).called(1);
    });
    
    test('removeTask calls repository', () async {
        // Arrange
      when(() => mockRepository.getTasks()).thenAnswer((_) async => []);
      when(() => mockRepository.removeTask(id: any(named: 'id')))
          .thenAnswer((_) async {});

      // Act
      await container.read(taskListProvider.notifier).removeTask(id: '1');

      // Assert
      verify(() => mockRepository.removeTask(id: '1')).called(1);
    });
    
     test('toggleComplete calls repository', () async {
        // Arrange
      when(() => mockRepository.getTasks()).thenAnswer((_) async => []);
      when(() => mockRepository.toggleComplete(id: any(named: 'id')))
          .thenAnswer((_) async {});

      // Act
      await container.read(taskListProvider.notifier).toggleComplete(id: '1');

      // Assert
      verify(() => mockRepository.toggleComplete(id: '1')).called(1);
    });
  });
}
