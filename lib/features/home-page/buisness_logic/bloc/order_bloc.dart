import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_model.dart';
import 'package:roadrunner_provider_app/features/home-page/data/repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<GetOrderListEvent>((event, emit) async {
      emit(OrderLoading());
      final result = await OrderRepository().getOrderList(event.date);

      result.fold((left) {
        emit(OrderFailure(message: left.message));
      }, (right) => emit(OrderSuccess(orderList: right)));
    });
  }
}
