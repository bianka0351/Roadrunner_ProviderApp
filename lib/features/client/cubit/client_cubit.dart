import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/constants/app_regex.dart';
import 'package:roadrunner_provider_app/features/client/cubit/client_state.dart';
import '../data/repositories/client_repository.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit() : super(ClientInitial());

  final ClientRepo _clientRepo = ClientRepo();

  void createClient({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String paymentMethod,
  }) async {
    // Validate email and phone number
    if (!_isValidEmail(email)) {
      emit(ClientFailure(message: 'Invalid email address'));
      return;
    }

    if (!_isValidPhoneNumber(phoneNumber)) {
      emit(ClientFailure(message: 'Invalid phone number'));
      return;
    }

    emit(ClientLoading());

    final result = await _clientRepo.createClient(
      firstName,
      lastName,
      email,
      phoneNumber,
      paymentMethod,
    );

    result.fold(
      (left) => emit(ClientFailure(message: left.message)),
      (right) => emit(ClientSuccess(client: right)),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = AppRegex.emailRegex;
   // RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = AppRegex.phoneRegex;
    //RegExp(r'^\+?[0-9]{10,}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}
