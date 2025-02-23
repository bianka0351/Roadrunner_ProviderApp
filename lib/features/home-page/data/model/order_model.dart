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
  final String? clientName;
  final String? clientImage;
  final String? startTime;
  final String? clientAddress;
  final String? status;
  final List<String>? orderServices;
  final List<String>? orderProducts;

  Order({
    this.clientName,
    this.clientImage,
    this.startTime,
    this.clientAddress,
    this.status,
    this.orderServices,
    this.orderProducts,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        clientName: json["ClientName"],
        clientImage: json["ClientImage"],
        startTime: json["StartTime"],
        clientAddress: json["ClientAddress"],
        status: json["Status"],
        orderServices: json["OrderServices"] == null
            ? []
            : List<String>.from(json["OrderServices"]!.map((x) => x)),
        orderProducts: json["OrderProducts"] == null
            ? []
            : List<String>.from(json["OrderProducts"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ClientName": clientName,
        "ClientImage": clientImage,
        "StartTime": startTime,
        "ClientAddress": clientAddress,
        "Status": status,
        "OrderServices": orderServices == null
            ? []
            : List<dynamic>.from(orderServices!.map((x) => x)),
        "OrderProducts": orderProducts == null
            ? []
            : List<dynamic>.from(orderProducts!.map((x) => x)),
      };
}
