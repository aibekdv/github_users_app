import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectionStatus { connected, disconnected }

class ConnectionCubit extends Cubit<ConnectionStatus> {
  final Connectivity _connectivity = Connectivity();

  ConnectionCubit() : super(ConnectionStatus.disconnected) {
    _checkConnectionStatus();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnectionStatus();
    });
  }

  Future<void> _checkConnectionStatus() async {
    var result = await _connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      emit(ConnectionStatus.connected);
    } else {
      emit(ConnectionStatus.disconnected);
    }
  }
}
