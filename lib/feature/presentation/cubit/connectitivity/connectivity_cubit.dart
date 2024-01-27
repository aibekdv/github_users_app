import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_state.dart';


class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityCubit(this._connectivity) : super(ConnectivityState.disconnected) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_connectivityChanged);
  }

  void _connectivityChanged(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(ConnectivityState.disconnected);
    } else {
      emit(ConnectivityState.connected);
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
