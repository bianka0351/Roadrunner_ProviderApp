import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network_event.dart';
import 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  bool _isFirstLoad = true; // Flag to track the first load

  NetworkBloc() : super(NetworkInitialState()) {
    on<ListenNetworkEvent>(_onListenNetwork);
    on<NetworkStatusChangedEvent>(_onNetworkStatusChanged);

    // Check initial connection status
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      add(NetworkStatusChangedEvent(isConnected: false, isFirstLoad: _isFirstLoad));
    } else {
      add(NetworkStatusChangedEvent(isConnected: true, isFirstLoad: _isFirstLoad));
    }
  }

  void _onListenNetwork(ListenNetworkEvent event, Emitter<NetworkState> emit) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.none) {
          add(NetworkStatusChangedEvent(isConnected: false, isFirstLoad: false));
        } else {
          add(NetworkStatusChangedEvent(isConnected: true, isFirstLoad: false));
        }
      },
    );
  }

  void _onNetworkStatusChanged(NetworkStatusChangedEvent event, Emitter<NetworkState> emit) {
    if (event.isConnected) {
      emit(NetworkConnectedState(isFirstLoad: event.isFirstLoad));
    } else {
      emit(NetworkDisconnectedState(isFirstLoad: event.isFirstLoad));
    }
    _isFirstLoad = false; // Set the flag to false after the first event
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}