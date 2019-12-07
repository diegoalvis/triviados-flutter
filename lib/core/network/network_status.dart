import 'package:data_connection_checker/data_connection_checker.dart';


class NetworkStatus {
  final DataConnectionChecker dataConnectionChecker;

  NetworkStatus(this.dataConnectionChecker);

  Future<bool> get isConnected {
    return dataConnectionChecker.hasConnection;
  }
}
