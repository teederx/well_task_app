// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredTaskListHash() => r'a4638a4635c4ce8c895559d1cba051328ac4c648';

/// See also [filteredTaskList].
@ProviderFor(filteredTaskList)
final filteredTaskListProvider = AutoDisposeFutureProvider<List<Task>>.internal(
  filteredTaskList,
  name: r'filteredTaskListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredTaskListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredTaskListRef = AutoDisposeFutureProviderRef<List<Task>>;
String _$taskFilterHash() => r'7496024a2fd4f0714c92c9cc9e0978076658cb8f';

/// See also [TaskFilter].
@ProviderFor(TaskFilter)
final taskFilterProvider =
    AutoDisposeNotifierProvider<TaskFilter, TaskFilterState>.internal(
      TaskFilter.new,
      name: r'taskFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$taskFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TaskFilter = AutoDisposeNotifier<TaskFilterState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
