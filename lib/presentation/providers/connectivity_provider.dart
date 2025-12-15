import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
class ConnectivityStatus extends _$ConnectivityStatus {
  @override
  Stream<List<ConnectivityResult>> build() {
    return Connectivity().onConnectivityChanged;
  }
}

@riverpod
bool isOffline(IsOfflineRef ref) {
  final connectivity = ref.watch(connectivityStatusProvider);
  return connectivity.when(
    data: (results) => results.contains(ConnectivityResult.none),
    loading: () => false, // Assume online initially
    error: (_, __) => false,
  );
}


