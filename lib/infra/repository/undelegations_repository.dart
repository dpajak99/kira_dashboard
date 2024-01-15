import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';
import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';
import 'package:kira_dashboard/infra/entities/staking/query_delegations_response.dart';
import 'package:kira_dashboard/infra/entities/staking/query_undelegations_response.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';

class UndelegationsRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<List<UndelegationEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/kira/undelegations',
      queryParameters: {'undelegatorAddress': address},
    );
    QueryUndelegationsResponse queryUndelegationsResponse = QueryUndelegationsResponse.fromJson(response.data!);

    return queryUndelegationsResponse.undelegations;
  }
}
