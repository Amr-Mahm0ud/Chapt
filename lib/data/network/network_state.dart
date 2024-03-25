import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkState {
  Future<bool> get isConnected;
}

class NetworkStateImp implements NetworkState {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkStateImp(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}
