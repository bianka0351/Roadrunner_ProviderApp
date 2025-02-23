// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
// import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_event.dart';
// import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_state.dart';
// import 'package:roadrunner_provider_app/features/profile/data/model/profile_model.dart';
// import 'package:roadrunner_provider_app/features/profile/data/repository/profile_repository.dart';

// class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
//   final ProfileRepository repository;

//   ProfileBloc({required this.repository}) : super(ProfileInitial()) {
//     on<FetchProfile>(_onFetchProfile);
//   }

//   // Handle fetching profile
//   Future<void> _onFetchProfile(
//       FetchProfile event, Emitter<ProfileState> emit) async {
//     emit(ProfileLoading());
//     final Either<Failure, RunnerProfile> result = await repository.getProfile();

//     result.fold((failure) => emit(ProfileError(failure.message)),
//         (profile) => emit(ProfileLoaded(profile)));
//   }
// }
