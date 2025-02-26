import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

// Initial state
class MapInitialState extends MapState {}

// Loading state
class MapLoadingState extends MapState {}

// Loaded state
class OrdersLocationsState extends MapState {
  final List<LatLng> ordersLocations;
  final List<LatLng> routePath;
  final List<Map<String, dynamic>> routeDetails;

  const OrdersLocationsState({
    required this.ordersLocations,
    required this.routeDetails,
    required this.routePath,
  });

  @override
  List<Object?> get props => [ordersLocations, routeDetails, routePath];
}

class OrderDetailLocationState extends MapState {
  final LatLng orderLocation;
  final LatLng runnerLocation;
  final List<Map<String, dynamic>> routeDetails;
  final List<LatLng> routePath;

  const OrderDetailLocationState({
    required this.orderLocation,
    required this.runnerLocation,
    required this.routeDetails,
    required this.routePath,
  });

  @override
  List<Object?> get props =>
      [orderLocation, runnerLocation, routeDetails, routePath];
}

// Error state
class MapErrorState extends MapState {
  final String message;

  const MapErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
