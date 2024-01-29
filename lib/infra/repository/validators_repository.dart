import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/validators/query_validators_response.dart';
import 'package:kira_dashboard/infra/entities/validators/validator_entity.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class ValidatorsRepository extends ApiRepository {
  Future<List<ValidatorEntity>> getAll() async {
    try {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/valopers',
      queryParameters: {'all': true},
    );
    QueryValidatorsResponse queryValidatorsResponse = QueryValidatorsResponse.fromJson(response.data!);

    return queryValidatorsResponse.validators;
    } catch (e) {
      AppLogger().log(message: 'ValidatorsRepository');
      rethrow;
    }
  }

  Future<ValidatorEntity?> getById(String address) async {
    try {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/valopers',
      queryParameters: {'address': address},
    );
    QueryValidatorsResponse queryValidatorsResponse = QueryValidatorsResponse.fromJson(response.data!);
    return queryValidatorsResponse.validators.firstOrNull;
    } catch (e) {
      AppLogger().log(message: 'ValidatorsRepository');
      rethrow;
    }
  }
}
