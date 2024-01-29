import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/query_verification_requests_response.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/verification_request_entity.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class VerificationRequestsRepository extends ApiRepository {
  Future<List<VerificationRequestEntity>> getInboundPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_verify_requests_by_approver/$address');
      QueryVerificationRequestsResponse queryVerificationRequestsResponse = QueryVerificationRequestsResponse.fromJson(response.data!);

      return queryVerificationRequestsResponse.verificationRequests;
    } catch (e) {
      AppLogger().log(message: 'VerificationRequestsRepository');
      rethrow;
    }
  }

  Future<List<VerificationRequestEntity>> getOutboundPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_verify_requests_by_requester/$address');
      QueryVerificationRequestsResponse queryVerificationRequestsResponse = QueryVerificationRequestsResponse.fromJson(response.data!);

      return queryVerificationRequestsResponse.verificationRequests;
    } catch (e) {
      AppLogger().log(message: 'VerificationRequestsRepository');
      rethrow;
    }
  }
}
