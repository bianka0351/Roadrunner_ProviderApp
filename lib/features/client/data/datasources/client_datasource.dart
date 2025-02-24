import 'package:roadrunner_provider_app/core/constants/app_endpoints.dart';
import 'package:roadrunner_provider_app/core/unified_api/post_api.dart';
import '../model/client.dart';

class ClientDatasource {
  Future<ClientResponseModel> createClient(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String paymentMethod,
  ) async {
    final postApi = PostApi(
      uri: Uri.parse(AppEndpoints.createClients),
      body: {
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'PhoneNumber': phoneNumber,
        'PaymentMethod': paymentMethod,
      },
      additionalHeaders: {AppEndpoints.headerName: AppEndpoints.headerValue},
      fromJson: clientResponseModelFromJson,
    );

    return await postApi.callRequest();
  }
}
