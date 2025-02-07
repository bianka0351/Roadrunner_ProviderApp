import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/exception_handling/failures.dart';
import 'package:roadrunner_provider_app/profile/data/model/profile_model.dart';
import 'package:roadrunner_provider_app/profile/data/service/profile_api.dart';

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

/*
class ProfileRepository {
  final ProfileApi profileApi;

  ProfileRepository({required this.profileApi});

  Future<Either<String, RunnerProfile>> getProfile() async {
    try {
      final response = await profileApi.fetchProfile();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final profile = RunnerProfile.fromJson(data);
        return Right(profile); // Return the profile on success
      } else {
        return Left('${response.statusCode}'); // Return error message
      }
    } catch (e) {
      return Left('Exception: ${e.toString()}');
    }
  }
}
*/
