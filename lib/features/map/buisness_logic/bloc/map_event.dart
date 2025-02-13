import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

// load map data with a list of order locations
class LoadMapDataEvent extends MapEvent {
  final List<LatLng> orderLocations;

  const LoadMapDataEvent(this.orderLocations);

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
