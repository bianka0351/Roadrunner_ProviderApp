import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';
import 'package:roadrunner_provider_app/features/map/data/model/map_data_type.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/order_location_marker.dart';

class MapWidget extends StatefulWidget {
  final MapDataType mapDataType;
  final List<String> locations;

  const MapWidget(
      {super.key, required this.locations, required this.mapDataType});

  @override
  State<StatefulWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();
  double _currentZoom = 11.0;
  LatLng _initialLocation = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    switch (widget.mapDataType) {
      case MapDataType.orders:
        context.read<MapBloc>().add(LoadOrdersLocationEvent(widget.locations));
        break;
    }
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 0.5).clamp(1.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 0.5).clamp(1.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _resetLocation() {
    _mapController.move(_initialLocation, _currentZoom);
    _mapController.rotate(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // The map
      BlocBuilder<MapBloc, MapState>(builder: (context, state) {
        // error state
        if (state is MapErrorState) {
          return Center(
            child: Text(state.message),
          );

          //loaded state
        } else if (state is OrdersLocationState) {
          _initialLocation = state.orderLocations.first;
          return FlutterMap(
            // map controller
            mapController: _mapController,
            // map options
            options: MapOptions(
              initialCenter: state.orderLocations.isNotEmpty
                  ? state.orderLocations.first
                  : LatLng(0, 0),
              initialZoom: _currentZoom,
            ),
            // map layers
            children: [
              // tile layer
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              // polyline layer
              PolylineLayer(polylines: [
                Polyline(
                    points: state.routePath,
                    color: AppColors.primaryColor,
                    strokeWidth: 5.0.w)
              ]),
              // marker layer
              MarkerLayer(
                alignment: Alignment.topCenter,
                markers: List.generate(state.orderLocations.length, (index) {
                  return Marker(
                      point: state.orderLocations[index],
                      width: 40.w,
                      height: 40.h,
                      child:
                          OrderLocationMarker(index: (index + 1).toString()));
                }).toList(),
              )
            ],
          );
        }
        // indicator
        return const Center(child: CircularProgressIndicator());
      }),
      // location button
      Positioned(
        bottom: 10.h,
        right: 5.w,
        child: ElevatedButton(
          onPressed: () {
            _resetLocation();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: AppColors.tertiaryColor, width: 1.w),
            ),
            padding: EdgeInsets.all(10.r),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Icon(
            Icons.my_location,
            size: 24,
            color: AppColors.tertiaryColor,
          ),
        ),
      ),
      // zoom in out buttons
      Positioned(
        bottom: 65.h,
        left: 5.w,
        child: ElevatedButton(
          onPressed: () {
            _zoomIn();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: AppColors.tertiaryColor, width: 1.w),
            ),
            padding: EdgeInsets.all(10.r),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Icon(
            Icons.add,
            size: 24,
            color: AppColors.tertiaryColor,
          ),
        ),
      ),

      // Zoom Out Button
      Positioned(
        bottom: 10.h,
        left: 5.w,
        child: ElevatedButton(
          onPressed: () {
            _zoomOut();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: AppColors.tertiaryColor, width: 1.w),
            ),
            padding: EdgeInsets.all(10.r),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Icon(
            Icons.remove,
            size: 24,
            color: AppColors.tertiaryColor,
          ),
        ),
      ),
    ]);
  }
}
