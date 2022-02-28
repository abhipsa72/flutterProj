import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:rxdart/subjects.dart';
import 'package:zel_app/util/enum_values.dart';

class ConnectivityService {
  final _connectionStatusController = BehaviorSubject<ConnectivityStatus>();
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityStatus> get connectionStream =>
      _connectionStatusController.stream;
  StreamSink<ConnectivityStatus> get connectionSink =>
      _connectionStatusController.sink;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      connectionSink.add(_getStatusFromResult(result));
      print(result);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
