import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:roadrunner_provider_app/core/exception_handling/exceptions.dart';

mixin HandlingRequestException {
  Exception getException({required Response response}) {
    String message = 'An unexpected error occurred';

    try {
      if (response.body.isNotEmpty) {
        final decodedBody = jsonDecode(response.body);
        if (decodedBody is Map<String, dynamic> &&
            decodedBody.containsKey('message')) {
          message = decodedBody['message'];
        }
      }
    } on FormatException catch (e) {
      log('JSON FormatException: ${e.message}');
    } catch (e) {
      log('Unexpected error decoding response: $e');
    }

    // handle HTTP status codes
    switch (response.statusCode) {
      case 400:
        return BadRequestException(message: message);
      case 401:
      case 403:
        return AuthException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 429:
        return ServerException(message: "Too many requests. Slow down.");
      case 500:
        return ServerException(message: message);
      case 502:
      case 503:
        return ServerException(message: "Service is temporarily unavailable.");
      default:
        return UnknownException(message: message);
    }
  }
}
