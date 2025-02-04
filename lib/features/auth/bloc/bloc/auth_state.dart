part of 'auth_bloc.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponseModel? auth;
  AuthSuccess({
    this.auth,
  });
}

class AuthFailure extends AuthState {}
