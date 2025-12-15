// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskHash() => r'b36d32c2592f9d14e1faf04c514de536e3388892';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [task].
@ProviderFor(task)
const taskProvider = TaskFamily();

/// See also [task].
class TaskFamily extends Family<Task> {
  /// See also [task].
  const TaskFamily();

  /// See also [task].
  TaskProvider call({required String id}) {
    return TaskProvider(id: id);
  }

  @override
  TaskProvider getProviderOverride(covariant TaskProvider provider) {
    return call(id: provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskProvider';
}

/// See also [task].
class TaskProvider extends AutoDisposeProvider<Task> {
  /// See also [task].
  TaskProvider({required String id})
    : this._internal(
        (ref) => task(ref as TaskRef, id: id),
        from: taskProvider,
        name: r'taskProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product') ? null : _$taskHash,
        dependencies: TaskFamily._dependencies,
        allTransitiveDependencies: TaskFamily._allTransitiveDependencies,
        id: id,
      );

  TaskProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(Task Function(TaskRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: TaskProvider._internal(
        (ref) => create(ref as TaskRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Task> createElement() {
    return _TaskProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TaskRef on AutoDisposeProviderRef<Task> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TaskProviderElement extends AutoDisposeProviderElement<Task>
    with TaskRef {
  _TaskProviderElement(super.provider);

  @override
  String get id => (origin as TaskProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
