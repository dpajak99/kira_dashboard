import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/query_verification_requests_response.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/verification_request_entity.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class VerificationRequestsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<VerificationRequestEntity>> getAllInbound(String address) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_verify_requests_by_approver/$address');
      QueryVerificationRequestsResponse queryVerificationRequestsResponse = QueryVerificationRequestsResponse.fromJson(response.data!);

      return queryVerificationRequestsResponse.verificationRequests;
    } catch (e) {
      AppLogger().log(message: 'VerificationRequestsRepository');
      rethrow;
    }
  }

  Future<List<VerificationRequestEntity>> getAllOutbound(String address) async {
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
