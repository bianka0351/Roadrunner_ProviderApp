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
class MapLoadedState extends MapState {
  final List<LatLng> orderLocations;
  final List<LatLng> routePath;

  const MapLoadedState({required this.orderLocations, required this.routePath});

  @override
  List<Object?> get props => [orderLocations, routePath];
}

// Error state
class MapErrorState extends MapState {
  final String message;

  const MapErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
