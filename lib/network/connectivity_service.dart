import 'package:connectivity/connectivity.dart';
import 'package:grand_uae/customer/enums/connectivity_status.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityService {
  final _connectionStatusController = BehaviorSubject<ConnectivityStatus>();
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityStatus> get connectionStream =>
      _connectionStatusController.stream;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((event) {
      _connectionStatusController.add(_getStatusFromResult(event));
    });
  }

// Convert from the third part enum to our own enum
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
