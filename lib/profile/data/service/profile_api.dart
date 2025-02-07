import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/exception_handling/failures.dart';
import 'package:roadrunner_provider_app/core/exception_handling/get_api.dart';
import 'package:roadrunner_provider_app/profile/data/model/profile_model.dart';

class ProfileApi {
  final String url; // URL is passed externally

  ProfileApi({required this.url});

  Future<Either<Failure, RunnerProfile>> fetchProfile() async {
    return await GetApi<RunnerProfile>(
      url: url,
      fromJson: (json) => RunnerProfile.fromJson(jsonDecode(json)),
      headers: {
        "Content-Type": "application/json",
        "FROM": "ProviderRR",
      },
    ).call();
  }
}
