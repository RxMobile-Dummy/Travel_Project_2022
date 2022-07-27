import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'internet_enum.dart';

class InternetCubit extends Cubit<BaseState> {
  final Connectivity? connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() async {
    connectivityStreamSubscription =
        connectivity!.onConnectivityChanged.listen((connectivityResult) async {
      try {
        final result = await InternetAddress.lookup("example.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          if (connectivityResult == ConnectivityResult.wifi) {
            emitInternetConnected(ConnectionType.WiFi);
          } else if (connectivityResult == ConnectivityResult.mobile) {
            emitInternetConnected(ConnectionType.Mobile);
          } else if (connectivityResult == ConnectivityResult.none) {
            emitInternetDisconnected();
          }
        }
      } on SocketException catch (_) {
        emitInternetDisconnected();
      }
    });
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
