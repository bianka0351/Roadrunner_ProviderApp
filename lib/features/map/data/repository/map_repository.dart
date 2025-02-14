import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
import 'package:roadrunner_provider_app/features/map/data/datasources/map_api.dart';

class MapRepository with HandlingExceptionManager {
  final MapApi mapApi = MapApi();

  MapRepository();

  Future<Either<Failure, List<LatLng>>> getRoute(List<LatLng> locations) async {
    return await handleError(tryCall: () async {
      final result = await mapApi.fetchMapRoutes(locations);
      return Right(result);
    });
  }
}
