import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

// load map data with a list of order locations
class LoadOrdersLocationEvent extends MapEvent {
  final List<String> orderLocations;

  const LoadOrdersLocationEvent(this.orderLocations);

  @override
  List<Object?> get props => [orderLocations];
}

// get current location
class GetCurrentLocationEvent extends MapEvent {
  final LatLng currentLocation;

  const GetCurrentLocationEvent(this.currentLocation);

  @override
  List<Object?> get props => [currentLocation];
}
