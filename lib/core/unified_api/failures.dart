
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {

  final String message;
  Failure({
    required this.message,
  });


  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({String message = "Server failure"}) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure({String message = "No internet connection"})
      : super(message: message);
}

class AuthFailure extends Failure {
  AuthFailure({String message = "Authentication failed"})
      : super(message: message);
}

class UnknownFailure extends Failure {
  UnknownFailure({String message = "Unknown failure"})
      : super(message: message);

}
