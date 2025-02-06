import 'package:http/http.dart' as http;

class ProfileApi {
  final String baseUrl;

  ProfileApi({required this.baseUrl});

  Future<http.Response> fetchProfile() async {
    return await http.get(Uri.parse('$baseUrl/getProfile'));
  }
}
