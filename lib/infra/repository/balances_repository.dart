import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';

class BalancesRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<List<CoinEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/balances/$address');
    QueryBalanceResponse queryBalanceResponse = QueryBalanceResponse.fromJson(response.data!);

    return queryBalanceResponse.balances;
  }
}
