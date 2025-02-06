import 'package:equatable/equatable.dart';
import 'package:roadrunner_provider_app/profile/data/model/profile_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial State
class ProfileInitial extends ProfileState {}

// Loading state
class ProfileLoading extends ProfileState {}

// Loaded state
class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Error state
class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
