import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
import 'package:roadrunner_provider_app/features/map/data/datasources/map_api2.dart';

class MapRepository with HandlingExceptionManager {
  final MapApi mapApi = MapApi();

  MapRepository();

  Future<Either<Failure, Map<String, dynamic>>> getLocationsRoutes(
      List<LatLng> locations) async {
    return await handleError(tryCall: () async {
      final result = await mapApi.getLocationsRoutesApi(locations);
      return Right(result);
    });
  }

  // routes addresses
  Future<Either<Failure, List<LatLng>>> getOrdersAdressLocation(
      List<String> addresses) async {
    return await handleError(tryCall: () async {
      final result = await mapApi.getAddressesLocationsApi(addresses);
      return Right(result);
    });
  }

  // order runner addresses
  Future<Either<Failure, List<LatLng>>> getOrderRunnerAddressLocations(
      String runner, String order) async {
    List<String> addresses = [];
    addresses.add(runner);
    addresses.add(order);
    return await handleError(tryCall: () async {
      final result = await mapApi.getAddressesLocationsApi(addresses);
      return Right(result);
    });
  }
  // order runner route
}
