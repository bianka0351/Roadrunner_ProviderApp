import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:roadrunner_provider_app/core/exception_handling/failures.dart';
import 'package:roadrunner_provider_app/core/exception_handling/handling_request_exception.dart';

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
        return Left(ServerFailure(message: e.toString()));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
