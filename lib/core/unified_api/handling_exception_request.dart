// This code is used to handle API responses and manage exceptions based on status codes.
import 'dart:convert';
import 'package:http/http.dart';
import 'package:roadrunner_provider_app/core/unified_api/exceptions.dart';

mixin HandlingExceptionRequest {
  Exception getException({required Response response}) {
    final String message = json.decode(response.body)['message'].toString();

    // if (response.statusCode == 401) return UnauthenticatedException(message);
    // if (response.statusCode == 413) return EmailUsedException();

    return ServerException(message);
  }
}
