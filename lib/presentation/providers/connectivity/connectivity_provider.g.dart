// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isOfflineHash() => r'aefda90cf427aa21a7737078144a5aa059ffd60a';

/// See also [isOffline].
@ProviderFor(isOffline)
final isOfflineProvider = AutoDisposeProvider<bool>.internal(
  isOffline,
  name: r'isOfflineProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isOfflineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsOfflineRef = AutoDisposeProviderRef<bool>;
String _$connectivityStatusHash() =>
    r'fc1b5e87b43513fb34abd07853417ef8918f409c';

/// See also [ConnectivityStatus].
@ProviderFor(ConnectivityStatus)
final connectivityStatusProvider = AutoDisposeStreamNotifierProvider<
  ConnectivityStatus,
  List<ConnectivityResult>
>.internal(
  ConnectivityStatus.new,
  name: r'connectivityStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectivityStatus =
    AutoDisposeStreamNotifier<List<ConnectivityResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
