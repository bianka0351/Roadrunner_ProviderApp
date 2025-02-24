import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/features/profile/data/model/profile_model.dart';
import 'package:roadrunner_provider_app/features/profile/data/service/profile_api.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';

class ProfileRepository with HandlingExceptionManager {
  final ProfileApi profileApi;

  ProfileRepository({required this.profileApi});

  Future<Either<Failure, RunnerProfile>> getProfile() async {
    return await handleError(
      tryCall: () async {
        final result = await profileApi.fetchProfile();
        return Right(result);
      },
    );
  }
}
