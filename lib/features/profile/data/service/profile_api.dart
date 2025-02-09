import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';
import 'package:roadrunner_provider_app/features/profile/data/model/profile_model.dart';

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
