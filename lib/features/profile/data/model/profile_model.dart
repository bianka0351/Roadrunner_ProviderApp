import 'package:equatable/equatable.dart';

class RunnerProfile extends Equatable {
  final String id;
  final String profileImage;
  final String username;
  final String email;
  final String address;
  final String phoneNumber;
  final String organizationTitle;
  final bool instantBooking;
  final List<WorkingHours> workingHours;

  const RunnerProfile({
    required this.id,
    required this.profileImage,
    required this.username,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.organizationTitle,
    required this.instantBooking,
    required this.workingHours,
  });

  factory RunnerProfile.fromJson(Map<String, dynamic> json) {
    return RunnerProfile(
      id: json['id'] ?? '',
      profileImage: json['profileImageURL'] ?? '',
      username: json['userName'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      organizationTitle: json['organizationTitle'] ?? '',
      instantBooking: json['allowInstantBooking'] ?? false,
      workingHours: (json['availabilitySchedules'] as List<dynamic>?)
              ?.map((e) => WorkingHours.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileImageURL': profileImage,
      'userName': username,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'organizationTitle': organizationTitle,
      'allowInstantBooking': instantBooking,
      'availabilitySchedules': workingHours.map((e) => e.toJson()).toList(),
    };
  }

  RunnerProfile copyWith({
    String? id,
    String? profileImage,
    String? username,
    String? email,
    String? address,
    String? phoneNumber,
    String? organizationTitle,
    bool? instantBooking,
    List<WorkingHours>? workingHours,
  }) {
    return RunnerProfile(
      id: id ?? this.id,
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      organizationTitle: organizationTitle ?? this.organizationTitle,
      instantBooking: instantBooking ?? this.instantBooking,
      workingHours: workingHours ?? this.workingHours,
    );
  }

  @override
  List<Object> get props => [
        id,
        profileImage,
        username,
        email,
        address,
        phoneNumber,
        organizationTitle,
        instantBooking,
        workingHours,
      ];
}

class WorkingHours extends Equatable {
  final String day;
  final String time;

  const WorkingHours({required this.day, required this.time});

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      day: json['day'] ?? '',
      time: json['time'] ?? '',
    );
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
