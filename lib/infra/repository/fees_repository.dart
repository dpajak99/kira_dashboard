import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/fees/fee_config_entity.dart';
import 'package:kira_dashboard/infra/entities/fees/query_execution_fee_response.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';

class FeesRepository extends ApiRepository {

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