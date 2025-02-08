import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/features/profile/data/model/profile_model.dart';
import 'package:roadrunner_provider_app/features/profile/data/service/profile_api.dart';

class ProfileRepository {
  final ProfileApi profileApi;

  ProfileRepository({required this.profileApi});

  Future<Either<Failure, RunnerProfile>> getProfile() async {
    final result = await profileApi.fetchProfile();

    return result.fold(
      (failure) => Left(failure),
      (profile) => Right(profile),
    );
  }
}
