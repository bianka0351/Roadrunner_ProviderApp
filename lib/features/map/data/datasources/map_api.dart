import 'dart:convert';

import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';

class MapApi {
  final String googleApiKey = 'AIzaSyDwgQ1FyQyylUg0r269Op9VekkpbzGR6tY';
  final String baseAddressUrl =
      'https://maps.googleapis.com/maps/api/geocode/json';

  MapApi();

  Future<Map<String, dynamic>?> getCoordinatesFromAddress(
      String address) async {
    final String url =
        '$baseAddressUrl?address=${Uri.encodeComponent(address)}&key=$googleApiKey';

    return await GetApi<Map<String, dynamic>>(
      url: url,
      fromJson: (response) => _parseAddress(json.decode(response)),
      headers: {
        'Content-Type': 'application/json',
      },
    ).call();
  }

  Map<String, dynamic> _parseAddress(Map<String, dynamic> response) {
    final location = response["results"][0]["geometry"]["location"];
    return {"lat": location["lat"], "lng": location["lng"]};
  }
}
