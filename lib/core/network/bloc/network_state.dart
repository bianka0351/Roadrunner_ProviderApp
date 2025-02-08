abstract class NetworkState {}

class NetworkInitialState extends NetworkState {}

class NetworkConnectedState extends NetworkState {
  final bool isFirstLoad;
  NetworkConnectedState({this.isFirstLoad = true});
}

class NetworkDisconnectedState extends NetworkState {
  final bool isFirstLoad;
  NetworkDisconnectedState({this.isFirstLoad = true});
}