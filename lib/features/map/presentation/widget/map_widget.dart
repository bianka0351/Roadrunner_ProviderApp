import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';

class MapWidget extends StatefulWidget {
  final List<LatLng> orderLocations;

  const MapWidget({super.key, required this.orderLocations});

  @override
  State<StatefulWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Dispatch the event when the widget initializes
    context.read<MapBloc>().add(LoadMapDataEvent(widget.orderLocations));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      // error state
      if (state is MapErrorState) {
        return Center(
          child: Text(state.message),
        );

        //loaded state
      } else if (state is MapLoadedState) {
        // Fit all markers inside view
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _fitAllLocations(state.orderLocations);
        });

        return FlutterMap(
          // map controller
          mapController: _mapController,
          // map options
          options: MapOptions(
            initialCenter: state.orderLocations.isNotEmpty
                ? state.orderLocations.first
                : LatLng(0, 0),
            initialZoom: 15.0,
          ),
          // map layers
          children: [
            // tile layer
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            // polyline layer
            PolylineLayer(polylines: [
              Polyline(
                  points: state.routePath,
                  color: AppColors.primaryColor,
                  strokeWidth: 6.0.w)
            ]),
            // marker layer
            MarkerLayer(
              markers: state.orderLocations.map((location) {
                return Marker(
                    point: location,
                    width: 40.w,
                    height: 40.h,
                    child: const Icon(
                      Icons.location_pin,
                      color: AppColors.tertiaryColor,
                      size: 30,
                    ));
              }).toList(),
            )
          ],
        );
      }
      // default starting state
      return const Center(child: CircularProgressIndicator());
    });
  }

  void _fitAllLocations(List<LatLng> locations) {
    if (locations.isEmpty) return;

    // Compute bounds for all locations
    double north = locations[0].latitude;
    double south = locations[0].latitude;
    double east = locations[0].longitude;
    double west = locations[0].longitude;

    for (var loc in locations) {
      if (loc.latitude > north) north = loc.latitude;
      if (loc.latitude < south) south = loc.latitude;
      if (loc.longitude > east) east = loc.longitude;
      if (loc.longitude < west) west = loc.longitude;
    }

    // Calculate the center of the bounds
    LatLng center = LatLng((north + south) / 2, (east + west) / 2);

    // Calculate the distance between the north and south, east and west for zoom calculation
    double latDiff = north - south;
    double lngDiff = east - west;

    // Determine a suitable zoom level based on the bounds
    double zoomLevel = _calculateZoomLevel(latDiff, lngDiff);

    // Move the map to the computed center with the calculated zoom level
    _mapController.move(center, zoomLevel);
  }

  double _calculateZoomLevel(double latDiff, double lngDiff) {
    // Start with a default zoom
    double zoom = 16.0;
    // Example logic to determine zoom level based on bounds
    if (latDiff == 0 && lngDiff == 0) return zoom;

    // Adjust zoom based on the difference in latitude and longitude
    double latZoom = 16.0 - (latDiff * 100);
    double lngZoom = 16.0 - (lngDiff * 100);

    zoom = latZoom < lngZoom ? latZoom : lngZoom;

    // Limit zoom to a reasonable range
    return zoom.clamp(10.0, 18.0);
  }
}
