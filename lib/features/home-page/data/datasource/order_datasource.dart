import 'package:roadrunner_provider_app/core/unified_api/get_api.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_model.dart';

class OrderDatasource {
  Future<OrderResponseModel> getOrderList({required String date}) async {
    final getApi = GetApi(
      url:
          "https://13595554-8941-48ff-b8d0-92fa31b0de0a.mock.pstmn.io/orders?date=$date",
      fromJson: orderResponseModelFromJson,
    );

    return await getApi.call();
  }
}
