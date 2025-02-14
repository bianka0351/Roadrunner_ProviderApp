import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';

class MapApi {
  final String baseUrl = 'https://router.project-osrm.org';

  MapApi();

  Future<List<LatLng>> fetchMapRoutes(List<LatLng> locations) async {
    final coords =
        locations.map((loc) => '${loc.longitude},${loc.latitude}').join(';');
    final String url =
        '$baseUrl/route/v1/driving/$coords?overview=full&geometries=geojson';

    return await GetApi<List<LatLng>>(
      url: url,
      fromJson: (json) => _parseRoute(jsonDecode(json)),
      headers: {
        'Content-Type': 'application/json',
      },
    ).call();
  }

  List<LatLng> _parseRoute(Map<String, dynamic> json) {
    final List<dynamic> routeCoords =
        json['routes'][0]['geometry']['coordinates'];
    return routeCoords.map((coord) => LatLng(coord[1], coord[0])).toList();
  }
}
