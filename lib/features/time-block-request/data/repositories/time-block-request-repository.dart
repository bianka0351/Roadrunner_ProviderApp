import '../datasources/time_block_request_api_service.dart';
import '../models/previous_time_block_requests_model.dart';
import '../models/time-block-request-model.dart';

abstract class TimeBlockRequestRepository {
  Future<void> submitRequest(TimeBlockRequestModel requestModel);
  Future<List<PreviousTimeBlockRequestModel>> getAllRequests({
    required String userId,
    required String organizationId,
  });
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
  Future<List<PreviousTimeBlockRequestModel>> getAllRequests({
    required String userId,
    required String organizationId,
  }) async {
    try {
      return await apiService.fetchAllRequests(
        userId: userId,
        organizationId: organizationId,
      );
    } catch (error) {
      throw Exception('Error fetching requests: $error');
    }
  }
}
