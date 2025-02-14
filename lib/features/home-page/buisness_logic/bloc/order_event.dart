part of 'order_bloc.dart';

class OrderEvent {}

class GetOrderListEvent extends OrderEvent {
  final String date;
  GetOrderListEvent({
    required this.date,
  });
}
