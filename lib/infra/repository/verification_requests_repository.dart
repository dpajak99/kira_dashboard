import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/query_verification_requests_response.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/verification_request_entity.dart';

class VerificationRequestsRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<List<VerificationRequestEntity>> getAllInbound(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_verify_requests_by_approver/$address');
    QueryVerificationRequestsResponse queryVerificationRequestsResponse = QueryVerificationRequestsResponse.fromJson(response.data!);

    return queryVerificationRequestsResponse.verificationRequests;
  }

  Future<List<VerificationRequestEntity>> getAllOutbound(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/identity_verify_requests_by_requester/$address');
    QueryVerificationRequestsResponse queryVerificationRequestsResponse = QueryVerificationRequestsResponse.fromJson(response.data!);

    return queryVerificationRequestsResponse.verificationRequests;
  }
}
