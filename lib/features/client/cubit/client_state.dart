
import '../data/model/client.dart';

class ClientState {}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientSuccess extends ClientState {
  final ClientResponseModel? client;
  ClientSuccess({this.client});
}

class ClientFailure extends ClientState {
  final String message;
  ClientFailure({required this.message});
}