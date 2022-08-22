import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base_state.dart';
import 'internet_enum.dart';

/// use this class for internet connectivity within application

class InternetCubit extends Cubit<BaseState> {
  final Connectivity? connectivity;
  ConnectivityResult? connectivityResults;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorCheckConnection();
    monitorInternetConnection();
  }

  void monitorInternetConnection() async {
    connectivityStreamSubscription =
        connectivity!.onConnectivityChanged.listen((connectivityResult) async {
      try {
        if (connectivityResult == ConnectivityResult.wifi) {
          emitInternetConnected(ConnectionType.WiFi);
        } else if (connectivityResult == ConnectivityResult.mobile) {
          emitInternetConnected(ConnectionType.Mobile);
        } else if (connectivityResult == ConnectivityResult.none) {
          emitInternetDisconnected();
        }
      } on SocketException catch (_) {
        emitInternetDisconnected();
      }
    });
  }

  void monitorCheckConnection() async {
    connectivityResults = await connectivity!.checkConnectivity();
    try {
      if (connectivityResults == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.WiFi);
      } else if (connectivityResults == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResults == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    } on SocketException catch (_) {
      emitInternetDisconnected();
    }
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() async {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
