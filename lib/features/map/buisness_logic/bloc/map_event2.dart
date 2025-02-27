import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

// load map data with a list of order locations
class LoadOrdersLocationsEvent extends MapEvent {
  final List<String> ordersAddresses;

  const LoadOrdersLocationsEvent({required this.ordersAddresses});

  @override
  List<Object?> get props => [ordersAddresses];
}

class LoadOrderDetailLocationEvent extends MapEvent {
  final String runnerAddress;
  final String orderAddress;

  const LoadOrderDetailLocationEvent(
      {required this.runnerAddress, required this.orderAddress});

  @override
  List<Object?> get props => [orderAddress, runnerAddress];
}

// get current location
class GetCurrentLocationEvent extends MapEvent {
  final LatLng currentLocation;

  const GetCurrentLocationEvent(this.currentLocation);

  @override
  List<Object?> get props => [currentLocation];
}
