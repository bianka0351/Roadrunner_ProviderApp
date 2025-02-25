// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/order_location_marker.dart';

class OrdersLocationsMap extends StatelessWidget {
  MapController mapController;
  double initialZoom;
  List<LatLng> routePath;
  List<LatLng> ordersLocations;

  OrdersLocationsMap(
      {super.key,
      required this.mapController,
      required this.initialZoom,
      required this.routePath,
      required this.ordersLocations});

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
          alignment: Alignment.topCenter,
          markers: List.generate(ordersLocations.length, (index) {
            return Marker(
                point: ordersLocations[index],
                width: 40.w,
                height: 40.h,
                child: OrderLocationMarker(index: (index + 1).toString()));
          }).toList(),
        )
      ],
    );
  }
}
