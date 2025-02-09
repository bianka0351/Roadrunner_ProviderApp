import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_request_exception.dart';

class GetApi<T> with HandlingRequestException {
  final String url;
  final T Function(String) fromJson;
  final Map<String, String>? headers;

  GetApi({required this.url, required this.fromJson, this.headers});

  Future<Either<Failure, T>> call() async {
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Right(fromJson(response.body));
      } else {
        Exception e = getException(response: response);
        log("API Error: ${e.toString()}");
        return Left(ServerFailure(message: e.toString()));
      }
    } on SocketException {
      log("No internet connection");
      return Left(NetworkFailure(message: "No internet connection"));
    } on TimeoutException {
      log("Request timeout");
      return Left(NetworkFailure(message: "Request timed out"));
    } on Exception catch (e) {
      log("Unexpected error: $e");
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
