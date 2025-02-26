// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';

class OrderRunnerLocationsMap extends StatelessWidget {
  MapController mapController;
  double initialZoom;
  List<LatLng> routePath;
  LatLng runnerLocation;
  LatLng orderLocation;

  OrderRunnerLocationsMap({
    super.key,
    required this.mapController,
    required this.initialZoom,
    required this.routePath,
    required this.runnerLocation,
    required this.orderLocation,
  });
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter:
            routePath.isNotEmpty ? routePath.first : LatLng(0.0, 0.0),
        initialZoom: initialZoom,
      ),
      // map layers
      children: [
        // tile layer
        TileLayer(
          urlTemplate:
              "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}"
        ),
        // polyline layer
        PolylineLayer(polylines: [
          Polyline(
              points: routePath,
              color: AppColors.primaryColor,
              strokeWidth: 5.0.w)
        ]),
        // marker layer
        MarkerLayer(
          markers: [
            // runner location marker
            Marker(
                alignment: Alignment.topCenter,
                width: 50.w,
                height: 50.w,
                point: runnerLocation,
                child: Icon(
                  Icons.location_pin,
                  color: AppColors.secondaryColor,
                  size: 50.w,
                )),
            // order location marker
            Marker(
                alignment: Alignment.topCenter,
                width: 50.w,
                height: 50.w,
                point: orderLocation,
                child: Icon(
                  Icons.location_pin,
                  color: AppColors.noShowStatusColor,
                  size: 50.w,
                )),
          ],
        )
      ],
    );
  }
}
