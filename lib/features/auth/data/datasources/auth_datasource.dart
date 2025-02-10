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
            'http://roadrunnergo.azurewebsites.net/api/ProviderAccountService/AccountValidation'),
        body: {
          'UserName': userName,
          'Password': password,
          'OrgName': organizationId,
        },
        additionalHeaders: {"FROM": "ProviderRR"},
        fromJson: authResponseModelFromJson);

    return await postApi.callRequest();
  }
}
