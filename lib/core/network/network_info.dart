import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp extends NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  @override
  NetworkInfoImp({@required this.dataConnectionChecker});
  Future<bool> get isConnected => this.dataConnectionChecker.hasConnection;
}
