import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  ConnectivityResult? _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    /// Adds a subscription to this stream.
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    /// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint("$e");
      return;
    }
    return _updateConnectionStatus(result);
  }

  /// Update Connection Status
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
  }

  /// Returns the current [ConnectivityResult].
  Future<bool> isNetworkConnected() async {
    if (_connectionStatus == null) {
      return await _connectivity.checkConnectivity() != ConnectivityResult.none;
    } else {
      return _connectionStatus != ConnectivityResult.none;
    }
  }

  @override
  void dispose() {
    ///Cancels this subscription.
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
