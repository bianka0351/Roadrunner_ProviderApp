import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/exception_handling/failures.dart';
import 'package:roadrunner_provider_app/core/exception_handling/get_api.dart';
import 'package:roadrunner_provider_app/profile/data/model/profile_model.dart';

class ProfileApi {
  final String baseUrl;

  ProfileApi({required this.baseUrl});

  Future<Either<Failure, RunnerProfile>> fetchProfile() async {
    return await GetApi<RunnerProfile>(
      url: '$baseUrl/GetProfile',
      fromJson: (json) => RunnerProfile.fromJson(jsonDecode(json)),
    ).call();
  }
}



/*
class ProfileApi {
  final String baseUrl;

  ProfileApi({required this.baseUrl});

  Future<http.Response> fetchProfile() async {
    return await http.get(Uri.parse('$baseUrl/getProfile'));
  }
}
*/