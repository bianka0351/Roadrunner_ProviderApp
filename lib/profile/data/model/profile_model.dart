import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String profileImage;
  final String username;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;

  const Profile({
    required this.profileImage,
    required this.username,
    required this.email,
    required this.password,
    required this.address,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage,
      'username': username,
      'email': email,
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileImage: json['profileImage'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Profile copyWith({
    String? profileImage,
    String? username,
    String? email,
    String? password,
    String? address,
    String? phoneNumber,
  }) {
    return Profile(
      profileImage: profileImage ?? this.profileImage,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object> get props =>
      [profileImage, username, email, password, address, phoneNumber];
}
