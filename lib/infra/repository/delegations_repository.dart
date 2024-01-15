import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';
import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';
import 'package:kira_dashboard/infra/entities/staking/query_delegations_response.dart';

class DelegationsRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<List<DelegationEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/kira/delegations',
      queryParameters: {'delegatorAddress': address},
    );
    QueryDelegationsResponse queryDelegationsResponse = QueryDelegationsResponse.fromJson(response.data!);

    return queryDelegationsResponse.delegations;
  }
}
