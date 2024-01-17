import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/validators/query_validators_response.dart';
import 'package:kira_dashboard/infra/entities/validators/validator_entity.dart';

class ValidatorsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<ValidatorEntity>> getAll() async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/valopers',
      queryParameters: {'all': true},
    );
    QueryValidatorsResponse queryValidatorsResponse = QueryValidatorsResponse.fromJson(response.data!);

    return queryValidatorsResponse.validators;
  }

  Future<ValidatorEntity?> getById(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/valopers',
      queryParameters: {'address': address},
    );
    QueryValidatorsResponse queryValidatorsResponse = QueryValidatorsResponse.fromJson(response.data!);
    return queryValidatorsResponse.validators.firstOrNull;
  }
}
