import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = "Server failure"});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = "No internet connection"});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = "Authentication failed"});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = "Unknown failure"});
}
