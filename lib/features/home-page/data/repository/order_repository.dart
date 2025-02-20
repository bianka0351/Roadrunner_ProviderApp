import 'package:dartz/dartz.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/core/unified_api/handling_exception_manager.dart';
import 'package:roadrunner_provider_app/features/home-page/data/datasource/order_datasource.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_detail_model.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_response_model.dart';

class OrderRepository with HandlingExceptionManager {
  Future<Either<Failure, OrderResponseModel>> getOrderList(String date) async {
    return handleError(tryCall: () async {
      final result = await OrderDatasource().getOrderList(date: date);
      return Right(result);
    });
  }

  Future<Either<Failure, OrderDetailModel>> getOrderDetail(int clientId) async {
    return handleError(tryCall: () async {
      final result = await OrderDatasource().getOrderDetail(clientId: clientId);
      return Right(result);
    });
  }
}
