import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/client.dart';
part 'client_addresses_state.dart';

class ClientAddressesCubit extends Cubit<ClientAddressesState> {
  final List<Address> _addresses = []; // Local list of addresses

  ClientAddressesCubit() : super(ClientAddressesInitial());

  // Getter for addresses
  List<Address> get addresses => _addresses;

  // Add an address
  void addAddress(Address address) {
    _addresses.add(address);
    emit(ClientAddressesUpdated(_addresses)); // Emit updated state
  }

  // Update an address
  void updateAddress(int index, Address newAddress) {
    if (index >= 0 && index < _addresses.length) {
      _addresses[index] = newAddress;
      emit(ClientAddressesUpdated(_addresses)); // Emit updated state
    }
  }

  // Delete an address
  void deleteAddress(int index) {
    if (index >= 0 && index < _addresses.length) {
      _addresses.removeAt(index);
      emit(ClientAddressesUpdated(_addresses)); // Emit updated state
    }
  }
}