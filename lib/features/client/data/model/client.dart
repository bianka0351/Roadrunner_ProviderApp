import 'dart:convert';

ClientResponseModel clientResponseModelFromJson(String str) =>
    ClientResponseModel.fromJson(json.decode(str));

String clientResponseModelToJson(ClientResponseModel data) =>
    json.encode(data.toJson());

class ClientResponseModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? imageFile;
  final List<Address>? addresses;
  final List<PaymentMethod>? paymentMethods;

  ClientResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userName,
    this.phoneNumber,
    this.imageFile,
    this.addresses,
    this.paymentMethods,
  });

  factory ClientResponseModel.fromJson(Map<String, dynamic> json) =>
      ClientResponseModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        imageFile: json["imageFile"],
        addresses: (json["addresses"] as List?)?.map((item) => Address.fromJson(item)).toList(),
        paymentMethods: (json["paymentMethods"] as List?)?.map((item) => PaymentMethod.fromJson(item)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "imageFile": imageFile,
        "addresses": addresses?.map((item) => item.toJson()).toList(),
        "paymentMethods": paymentMethods?.map((item) => item.toJson()).toList(),
      };
}

class Address {
  final String streetAddress;
  final String city;
  final String stateCode;
  final String zipCode;
  final String countryCode;

  Address({
    required this.streetAddress,
    required this.city,
    required this.stateCode,
    required this.zipCode,
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        streetAddress: json['streetAddress'],
        city: json['city'],
        stateCode: json['stateCode'],
        zipCode: json['zipCode'],
        countryCode: json['countryCode'],
      );

  Map<String, dynamic> toJson() => {
        'streetAddress': streetAddress,
        'city': city,
        'stateCode': stateCode,
        'zipCode': zipCode,
        'countryCode': countryCode,
      };
}

class PaymentMethod {
  final String label;
  final String cardNumber;
  final String expirationDate;
  final int cvc;
  final String cardHolderName;
  final Address address;

  PaymentMethod({
    required this.label,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvc,
    required this.cardHolderName,
    required this.address,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        label: json['label'],
        cardNumber: json['cardNumber'],
        expirationDate: json['expirationDate'],
        cvc: json['cvc'],
        cardHolderName: json['cardHolderName'],
        address: Address.fromJson(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'cardNumber': cardNumber,
        'expirationDate': expirationDate,
        'cvc': cvc,
        'cardHolderName': cardHolderName,
        'address': address.toJson(),
      };
}
