import '../models/time-block-request-model.dart';
import '../datasources/time_block_request_api_service.dart';

abstract class TimeBlockRequestRepository {
  Future<void> submitRequest(TimeBlockRequestModel requestModel);
  Future<List<TimeBlockRequestModel>> getAllRequests();
}

class TimeBlockRequestRepositoryImpl implements TimeBlockRequestRepository {
  final TimeBlockRequestApiService apiService;

  TimeBlockRequestRepositoryImpl({required this.apiService});

  @override
  Future<void> submitRequest(TimeBlockRequestModel requestModel) async {
    try {
      await apiService.submitTimeBlockRequest(requestModel);
    } catch (error) {
      throw Exception('Error submitting request: $error');
    }
  }

  @override
  Future<List<TimeBlockRequestModel>> getAllRequests() async {
    try {
      return await apiService.fetchAllRequests();
    } catch (error) {
      throw Exception('Error fetching requests: $error');
    }
  }
}
