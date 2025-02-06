import 'package:equatable/equatable.dart';

class RunnerProfile extends Equatable {
  final String profileImage;
  final String username;
  final String email;
  final String address;
  final String phoneNumber;
  final String organizationId;
  final bool instantBooking;
  final List<WorkingHours> workingHours;

  const RunnerProfile({
    required this.profileImage,
    required this.username,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.organizationId,
    required this.instantBooking,
    required this.workingHours,
  });

  Map<String, dynamic> toJson() {
    return {
      'profile_image': profileImage,
      'username': username,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'organization_id': organizationId,
      'instant_booking': instantBooking,
      'working_hours': workingHours.map((e) => e.toJson()).toList(),
    };
  }

  factory RunnerProfile.fromJson(Map<String, dynamic> json) {
    return RunnerProfile(
      profileImage: json['profile_image'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      organizationId: json['organization_id'] ?? '',
      instantBooking: json['instant_booking'] ?? '',
      workingHours: (json['working_hours'] as List<dynamic>?)
              ?.map((e) => WorkingHours.fromJson(e))
              .toList() ??
          [],
    );
  }

  RunnerProfile copyWith({
    String? profileImage,
    String? username,
    String? email,
    String? address,
    String? phoneNumber,
    String? organizationId,
    bool? instantBooking,
    List<WorkingHours>? workingHours,
  }) {
    return RunnerProfile(
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      organizationId: organizationId ?? this.organizationId,
      instantBooking: instantBooking ?? this.instantBooking,
      workingHours: workingHours ?? this.workingHours,
    );
  }

  @override
  List<Object> get props => [
        profileImage,
        username,
        email,
        address,
        phoneNumber,
        organizationId,
        profileImage,
        instantBooking,
        workingHours
      ];
}

class WorkingHours {
  final String day;
  final String time;

  WorkingHours({required this.day, required this.time});

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(day: json['day'] ?? '', time: json['time'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'time': time,
    };
  }

  WorkingHours copyWith({String? day, String? time}) {
    return WorkingHours(
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }

  @override
  List<Object> get props => [day, time];
}
