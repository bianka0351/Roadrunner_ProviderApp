import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';

class MapApi {
  final String baseOrdersLocationUrl = 'https://router.project-osrm.org';
  final String baseOrderAddressUrl = 'https://nominatim.openstreetmap.org';

  MapApi();

  Future<Map<String, dynamic>> getOrdersLocationRoutesApi(
      List<LatLng> locations) async {
    final coords =
        locations.map((loc) => '${loc.longitude},${loc.latitude}').join(';');
    final String url =
        '$baseOrdersLocationUrl/route/v1/driving/$coords?overview=full&geometries=geojson';

    return await GetApi<Map<String, dynamic>>(
      url: url,
      fromJson: (json) => _parseRoute(jsonDecode(json)),
      headers: {
        'Content-Type': 'application/json',
      },
    ).call();
  }

  Future<List<LatLng>> getOrdersAddressLocationApi(
      List<String> addresses) async {
    List<LatLng> locations = [];

    for (String address in addresses) {
      final encodedAddress = Uri.encodeComponent(address);
      final String addressUrl =
          '$baseOrderAddressUrl/search?q=$encodedAddress&format=json';

      LatLng? latLng = await GetApi<LatLng?>(
        url: addressUrl,
        fromJson: (json) => _parseAddress(json),
        headers: {
          'User-Agent': 'FlutterApp',
        },
      ).call();

      if (latLng != null) {
        locations.add(latLng);
      } else {
        print(
            'No coordinates found for address: $address'); // Log when no coordinates found
      }
      await Future.delayed(Duration(seconds: 1));
    }

    return locations;
  }

  Map<String, dynamic> _parseRoute(Map<String, dynamic> json) {
    final List<dynamic> routeCoords =
        json['routes'][0]['geometry']['coordinates'];
    final List<dynamic> legs = json['routes'][0]['legs'];

    List<LatLng> routePath = [];
    List<Map<String, String>> routeDetails = [];

    // Extract route path
    for (var coord in routeCoords) {
      routePath.add(LatLng(coord[1], coord[0]));
    }

    // Extract distance & duration
    for (int i = 0; i < legs.length; i++) {
      double distanceMeters = (legs[i]['distance'] as num).toDouble();
      double durationSeconds = (legs[i]['duration'] as num).toDouble();

      double distanceMiles =
          distanceMeters * 0.000621371; // Convert meters to miles
      int hours = (durationSeconds ~/ 3600);
      int minutes = ((durationSeconds % 3600) ~/ 60);

      routeDetails.add({
        "from": "${routePath[i]}",
        "to": "${routePath[i + 1]}",
        "distance": "${distanceMiles.toStringAsFixed(2)} mi",
        "duration": "$hours h $minutes min"
      });
    }

    return {
      "routePath": routePath, // List of LatLng for the map
      "routeDetails": routeDetails // Distance & duration between each point
    };
  }

  LatLng? _parseAddress(String json) {
    final List<dynamic> data = jsonDecode(json);
    if (data.isNotEmpty) {
      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);
      return LatLng(lat, lon);
    }
    return null;
  }
}
