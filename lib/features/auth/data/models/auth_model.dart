// To parse this JSON data, do
//
//     final authResponseModel = authResponseModelFromJson(jsonString);

import 'dart:convert';

AuthResponseModel authResponseModelFromJson(String str) =>
    AuthResponseModel.fromJson(json.decode(str));

String authResponseModelToJson(AuthResponseModel data) =>
    json.encode(data.toJson());

class AuthResponseModel {
  final String? id;
  final String? roleName;

  AuthResponseModel({
    this.id,
    this.roleName,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        id: json["id"],
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
      };
}
