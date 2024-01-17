import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';

class BalancesRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<CoinEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/balances/$address');
    QueryBalanceResponse queryBalanceResponse = QueryBalanceResponse.fromJson(response.data!);

    return queryBalanceResponse.balances;
  }
}
