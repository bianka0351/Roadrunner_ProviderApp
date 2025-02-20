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
class OrdersLocationState extends MapState {
  final List<LatLng> orderLocations;
  final List<LatLng> routePath;
  final List<Map<String, dynamic>> routeDetails;

  const OrdersLocationState({
    required this.orderLocations,
    required this.routeDetails,
    required this.routePath,
  });

  @override
  List<Object?> get props => [routeDetails, routePath];
}

// Error state
class MapErrorState extends MapState {
  final String message;

  const MapErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
