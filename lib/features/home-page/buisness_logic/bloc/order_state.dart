part of 'order_bloc.dart';

class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final List<Order>? orderList;
  OrderSuccess({
    this.orderList,
  });
}

class OrderDetailSuccess extends OrderState {
  final OrderDetailModel? details;
  OrderDetailSuccess({
    this.details,
  });
}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure({required this.message});
}
