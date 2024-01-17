import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/staking/query_undelegations_response.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';

class UndelegationsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<UndelegationEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/kira/undelegations',
      queryParameters: {'undelegatorAddress': address},
    );
    QueryUndelegationsResponse queryUndelegationsResponse = QueryUndelegationsResponse.fromJson(response.data!);

    return queryUndelegationsResponse.undelegations;
  }
}
