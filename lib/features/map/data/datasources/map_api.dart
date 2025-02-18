import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';

class MapApi {
  final String baseOrdersLocationUrl = 'https://router.project-osrm.org';
  final String baseOrderAddressUrl = 'https://nominatim.openstreetmap.org';

  MapApi();

  Future<List<LatLng>> getOrdersLocationRoutesApi(
      List<LatLng> locations) async {
    final coords =
        locations.map((loc) => '${loc.longitude},${loc.latitude}').join(';');
    final String url =
        '$baseOrdersLocationUrl/route/v1/driving/$coords?overview=full&geometries=geojson';

    return await GetApi<List<LatLng>>(
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

  List<LatLng> _parseRoute(Map<String, dynamic> json) {
    final List<dynamic> routeCoords =
        json['routes'][0]['geometry']['coordinates'];
    return routeCoords.map((coord) => LatLng(coord[1], coord[0])).toList();
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
