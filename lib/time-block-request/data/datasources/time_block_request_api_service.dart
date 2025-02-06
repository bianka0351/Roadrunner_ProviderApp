// import 'package:http/http.dart' as http;

// class TimeBlockRequestApiService {
//   final String baseUrl;

//   TimeBlockRequestApiService({required this.baseUrl});

//   Future<void> fetchTimeBlockRequests() async {
//     // Implement the logic to fetch data from the API.
//     // Example:
//     final response = await http.get(Uri.parse('$baseUrl/time-block-requests'));
//     if (response.statusCode == 200) {
//       // Handle successful response.
//     } else {
//       // Handle error response.
//       throw Exception('Failed to fetch time block requests');
//     }
//   }

//   Future<void> createTimeBlockRequest(Map<String, dynamic> data) async {
//     // Implement the logic to create a time block request.
//     final response = await http.post(
//       Uri.parse('$baseUrl/time-block-requests'),
//       body: data,
//     );
//     if (response.statusCode == 201) {
//       // Handle successful creation.
//     } else {
//       // Handle error response.
//       throw Exception('Failed to create time block request');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/time-block-request-model.dart';

class TimeBlockRequestApiService {
  final String baseUrl;

  TimeBlockRequestApiService({required this.baseUrl});

  // POST: Submit TimeBlockRequest
  Future<void> submitTimeBlockRequest(TimeBlockRequestModel requestModel) async {
    final url = Uri.parse('$baseUrl/time-block-request');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestModel.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit Time Block Request: ${response.body}');
    }
  }

  // GET: Fetch all TimeBlockRequests (if needed)
  Future<List<TimeBlockRequestModel>> fetchAllRequests() async {
    final url = Uri.parse('$baseUrl/time-block-requests');
    final response = await http.get(url, headers: {'Accept': 'application/json'});

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Time Block Requests');
    }

    final List<dynamic> responseBody = jsonDecode(response.body);
    return responseBody.map((json) => TimeBlockRequestModel.fromJson(json)).toList();
  }
}
