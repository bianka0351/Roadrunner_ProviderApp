part of 'client_addresses_cubit.dart';

abstract class ClientAddressesState {}

class ClientAddressesInitial extends ClientAddressesState {}

class ClientAddressesUpdated extends ClientAddressesState {
  final List<Address> addresses;
  ClientAddressesUpdated(this.addresses);
}