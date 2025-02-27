import 'dart:convert';
import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';

class MapApi {
  final String baseLocationUrl = 'https://router.project-osrm.org';
  final String baseAddressUrl = 'https://nominatim.openstreetmap.org';

  MapApi();

  Future<Map<String, dynamic>> getLocationsRoutesApi(
      List<LatLng> locations) async {
    final coords =
        locations.map((loc) => '${loc.longitude},${loc.latitude}').join(';');
    final String url =
        '$baseLocationUrl/route/v1/driving/$coords?overview=full&geometries=geojson';

    return await GetApi<Map<String, dynamic>>(
      url: url,
      fromJson: (json) => _parseRoute(jsonDecode(json)),
      headers: {
        'Content-Type': 'application/json',
      },
    ).call();
  }

  Future<List<LatLng>> getAddressesLocationsApi(List<String> addresses) async {
    List<LatLng> locations = [];

    /// I used this since I dont want to throw an exception from Nominatim Api
    // if null -------> use geocoding instead
    for (String address in addresses) {
      log("🔍 Searching for address: $address");
      LatLng? latLng = await _getLocationFromNominatim(address);

      // If Nominatim fails, use geocoding as a fallback
      // ignore: prefer_conditional_assignment

      if (latLng == null) {
        log("⚠️ Nominatim failed! Trying Geocoding...");
        latLng = await _getLocationFromGeocoding(address);
      }

      if (latLng != null) {
        locations.add(latLng);
      } else {
        log("❌ No coordinates found for: $address");
      }

      await Future.delayed(Duration(seconds: 1)); // To avoid API rate limits
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
      double lat = (coord[1] as num).toDouble();
      double lng = (coord[0] as num).toDouble();

      routePath.add(LatLng(lat, lng));
    }

    // Extract distance & duration
    for (int i = 0; i < legs.length; i++) {
      double distanceMeters = (legs[i]['distance'] as num).toDouble();
      double durationSeconds = (legs[i]['duration'] as num).toDouble();

      double distanceMiles =
          distanceMeters * 0.000621371; // Convert meters to miles
      int hours = (durationSeconds ~/ 3600);
      int minutes = ((durationSeconds % 3600) ~/ 60);

      if (i + 1 < routePath.length) {
        routeDetails.add({
          "from": "${routePath[i]}",
          "to": "${routePath[i + 1]}",
          "distance": "${distanceMiles.toStringAsFixed(2)} mil",
          "duration": "$hours h $minutes min"
        });
      }
    }

    return {
      "routePath": routePath, // List of LatLng for the map
      "routeDetails": routeDetails // Distance & duration between each point
    };
  }

  LatLng? _parseAddress(Map<String, dynamic> json) {
    if (json['status'] == 'OK' && json['results'].isNotEmpty) {
      final location = json['results'][0]['geometry']['location'];
      final lat = location['lat'];
      final lon = location['lng'];
      return LatLng(lat, lon);
    }
    return null;
  }

  Future<LatLng?> _getLocationFromGeocoding(String address) async {
    try {
      log("📍 [Geocoding] Trying local geocoder for: $address");
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final lat = locations.first.latitude;
        final lon = locations.first.longitude;
        log("✅ [Geocoding] Found: $address -> ($lat, $lon)");
        return LatLng(lat, lon);
      }
    } catch (e) {
      log("❌ [Geocoding] Failed to find: $address");
    }
    return null;
  }

  Future<LatLng?> _getLocationFromNominatim(String address) async {
    try {
      log("🌍 [Nominatim] Searching for: $address");
      final encodedAddress = Uri.encodeComponent(address);
      final String addressUrl =
          '$baseAddressUrl/search?q=$encodedAddress&format=json';

      final response = await http.get(Uri.parse(addressUrl), headers: {
        'User-Agent': 'FlutterApp',
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          log("✅ [Nominatim] Found: $address -> ($lat, $lon)");
          return LatLng(lat, lon);
        }
      } else {
        log("❌ [Nominatim] No results for: $address");
      }
    } catch (e) {
      log("⚠️ [Nominatim] Error");
    }

    return null;
  }
}
