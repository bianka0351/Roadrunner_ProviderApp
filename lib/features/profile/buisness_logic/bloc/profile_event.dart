import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// fetch profile data from api
class FetchProfile extends ProfileEvent {}
