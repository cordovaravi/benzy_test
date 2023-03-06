import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class ConncetionInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements ConncetionInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
