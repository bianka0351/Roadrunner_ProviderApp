import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/data/model/auth_model.dart';
import 'package:roadrunner_provider_app/features/auth/data/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await AuthRepo()
          .signIn(event.organizationId, event.userName, event.password);
      result.fold((left) {
        emit(AuthFailure(message: left.message));
      }, (right) => emit(AuthSuccess(auth: right)));
    });
  }
}
