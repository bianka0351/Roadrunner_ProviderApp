part of 'auth_bloc.dart';

class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String organizationId, userName, password;
  SignInEvent({
    required this.organizationId,
    required this.userName,
    required this.password,
  });
}
