import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

typedef ConnectionRestoredCallback = void Function();

class InternetService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _wasDisconnected = false;

  Future<InternetService> init(ConnectionRestoredCallback onConnected) async {
    final results = await _connectivity.checkConnectivity();
    _wasDisconnected = results.isEmpty || results.contains(ConnectivityResult.none);

    _subscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final hasConnection = results.any((r) => r != ConnectivityResult.none);

      if (_wasDisconnected && hasConnection) {
        _wasDisconnected = false;
        onConnected();
      }

      if (!hasConnection) {
        _wasDisconnected = true;
      }
    });

    return this;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
