import 'dart:convert';

import 'package:http/http.dart';
import 'package:roadrunner_provider_app/core/exception_handling/exceptions.dart';

mixin HandlingRequestException {
  Exception getException({required Response response}) {
    String message = 'An unexpected error occurred';

    try {
      final decodedBody = jsonDecode(response.body);
      if (decodedBody is Map<String, dynamic> &&
          decodedBody.containsKey('message')) {
        message = decodedBody['message'];
      }
    } catch (e) {}

    // handle HTTP status codes
    switch (response.statusCode) {
      case 400:
        return BadRequestException(message: message);
      case 401:
      case 403:
        return AuthException(message: message);
      case 404:
        return NotFoundException(message: message);
      case 500:
        return ServerException(message: message);
      default:
        return UnknownException(message: message);
    }
  }
}
