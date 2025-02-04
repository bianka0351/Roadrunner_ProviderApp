import 'package:roadrunner_provider_app/core/unified_api/post_api.dart';
import 'package:roadrunner_provider_app/features/auth/data/models/auth_model.dart';

class AuthDatasource {
  Future<AuthResponseModel> signIn(
    String organizationId,
    String userName,
    String password,
  ) async {
    final postApi = PostApi(
        uri: Uri.parse(
            'https://13595554-8941-48ff-b8d0-92fa31b0de0a.mock.pstmn.io/checkRunner'),
        body: {
          'organizationid': organizationId,
          'username': userName,
          'password': password,
        },
        fromJson: authResponseModelFromJson);

    return await postApi.callRequest();
  }
}
