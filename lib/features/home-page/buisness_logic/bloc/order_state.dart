part of 'order_bloc.dart';

class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final OrderResponseModel? orderList;
  OrderSuccess({
    this.orderList,
  });
}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure({required this.message});
}
