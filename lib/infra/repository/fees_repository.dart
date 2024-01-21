import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/fees/fee_config_entity.dart';
import 'package:kira_dashboard/infra/entities/fees/query_execution_fee_response.dart';

class FeesRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<FeeConfigEntity> getFee(String message) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/gov/execution_fee',
        queryParameters: {
          'message': message,
        }
      );

      QueryExecutionFeeResponse queryExecutionFeeResponse = QueryExecutionFeeResponse.fromJson(response.data!);

      return queryExecutionFeeResponse.fee;
    } catch (e) {
      rethrow;
    }
  }
}