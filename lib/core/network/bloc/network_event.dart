// Events
abstract class NetworkEvent {}

class ListenNetworkEvent extends NetworkEvent {}

class NetworkStatusChangedEvent extends NetworkEvent {
  final bool isConnected;
  final bool isFirstLoad;

  NetworkStatusChangedEvent({
    required this.isConnected,
    required this.isFirstLoad,
  });

  List<Object?> get props => [isConnected, isFirstLoad];
}