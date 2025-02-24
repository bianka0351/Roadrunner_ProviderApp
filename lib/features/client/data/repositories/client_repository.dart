import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
import '../datasources/client_datasource.dart';
import '../model/client.dart';

class ClientRepo with HandlingExceptionManager {
  Future<Either<Failure, ClientResponseModel>> createClient(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String paymentMethod,
  ) async {
    return handleError(tryCall: () async {
      final result = await ClientDatasource().createClient(
        firstName,
        lastName,
        email,
        phoneNumber,
        paymentMethod,
      );
      return Right(result);
    });
  }
}