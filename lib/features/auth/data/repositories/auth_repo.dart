import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
import 'package:roadrunner_provider_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:roadrunner_provider_app/features/auth/data/models/auth_model.dart';

class AuthRepo with HandlingExceptionManager {
  Future<Either<Failure, AuthResponseModel>> signIn(
      String organizationId, String userName, String password) async {
    return handleError(tryCall: () async {
      final result =
          await AuthDatasource().signIn(organizationId, userName, password);
      return Right(result);
    });
  }
}
