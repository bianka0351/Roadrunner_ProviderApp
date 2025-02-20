// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  final List<Order>? orders;

  OrderResponseModel({
    this.orders,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  final int? clientId;
  final String? clientName;
  final dynamic clientImage;
  final String? startTime;
  final ClientAddress? clientAddress;
  final String? status;
  final String? durationTime;
  final String? phoneNumber;
  final List<OrderService>? orderServices;
  final List<OrderAddOn>? orderAddOns;
  final List<OrderProduct>? orderProducts;

  Order({
    this.clientId,
    this.clientName,
    this.clientImage,
    this.startTime,
    this.clientAddress,
    this.status,
    this.durationTime,
    this.phoneNumber,
    this.orderServices,
    this.orderAddOns,
    this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        clientId: json["ClientId"],
        clientName: json["ClientName"],
        clientImage: json["ClientImage"],
        startTime: json["StartTime"],
        clientAddress: json["ClientAddress"] == null
            ? null
            : ClientAddress.fromJson(json["ClientAddress"]),
        status: json["Status"],
        durationTime: json["DurationTime"],
        phoneNumber: json["PhoneNumber"],
        orderServices: json["OrderServices"] == null
            ? []
            : List<OrderService>.from(
                json["OrderServices"]!.map((x) => OrderService.fromJson(x))),
        orderAddOns: json["OrderAddOns"] == null
            ? []
            : List<OrderAddOn>.from(
                json["OrderAddOns"]!.map((x) => OrderAddOn.fromJson(x))),
        orderProducts: json["OrderProducts"] == null
            ? []
            : List<OrderProduct>.from(
                json["OrderProducts"]!.map((x) => OrderProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ClientId": clientId,
        "ClientName": clientName,
        "ClientImage": clientImage,
        "StartTime": startTime,
        "ClientAddress": clientAddress?.toJson(),
        "Status": status,
        "DurationTime": durationTime,
        "PhoneNumber": phoneNumber,
        "OrderServices": orderServices == null
            ? []
            : List<dynamic>.from(orderServices!.map((x) => x.toJson())),
        "OrderAddOns": orderAddOns == null
            ? []
            : List<dynamic>.from(orderAddOns!.map((x) => x.toJson())),
        "OrderProducts": orderProducts == null
            ? []
            : List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
      };
}

class ClientAddress {
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;

  ClientAddress({
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  factory ClientAddress.fromJson(Map<String, dynamic> json) => ClientAddress(
        streetAddress: json["StreetAddress"],
        city: json["City"],
        state: json["State"],
        zipCode: json["ZipCode"],
        country: json["Country"],
      );

  Map<String, dynamic> toJson() => {
        "StreetAddress": streetAddress,
        "City": city,
        "State": state,
        "ZipCode": zipCode,
        "Country": country,
      };
}

class OrderAddOn {
  final String? addOnsName;
  final String? price;

  OrderAddOn({
    this.addOnsName,
    this.price,
  });

  factory OrderAddOn.fromJson(Map<String, dynamic> json) => OrderAddOn(
        addOnsName: json["AddOnsName"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "AddOnsName": addOnsName,
        "Price": price,
      };
}

class OrderProduct {
  final String? productName;
  final String? price;

  OrderProduct({
    this.productName,
    this.price,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        productName: json["ProductName"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "ProductName": productName,
        "Price": price,
      };
}

class OrderService {
  final String? serviceName;
  final String? price;

  OrderService({
    this.serviceName,
    this.price,
  });

  factory OrderService.fromJson(Map<String, dynamic> json) => OrderService(
        serviceName: json["ServiceName"],
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "ServiceName": serviceName,
        "Price": price,
      };
}
