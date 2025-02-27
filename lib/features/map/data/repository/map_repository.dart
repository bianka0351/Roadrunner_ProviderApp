import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
import 'package:roadrunner_provider_app/features/map/data/datasources/map_api.dart';

class MapRepository with HandlingExceptionManager {
  final MapApi mapApi = MapApi();

  MapRepository();

  Future<Either<Failure, Map<String, dynamic>>> getLocationCoordinate(
      String address) async {
    return await handleError(tryCall: () async {
      final result = await mapApi.getCoordinatesFromAddress(address);
      return Right(result!);
    });
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> getLocationsCoordinates(
      List<String> addresses) async {
    List<Map<String, dynamic>>? locations = [];
    Map<String, dynamic>? result = {};
    for (String address in addresses) {
      log('looking for address: $address');
      result = await mapApi.getCoordinatesFromAddress(address);
      if (result != null) {
        log('address found: $result');
        locations.add(result); // Add the result (not address)
      }
    }
    return Right(locations);
  }
}
