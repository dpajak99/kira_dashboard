import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class BalancesRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<CoinEntity>> getAll(String address) async {
    List<CoinEntity> coinEntities = List<CoinEntity>.empty(growable: true);
    int offset = 0;
    int limit = 500;
    bool downloadedAll = false;

    try {
      while(downloadedAll == false) {
        Response<Map<String, dynamic>> response = await httpClient.get(
          '/api/kira/balances/$address',
          queryParameters: {
            'offset': offset,
            'limit': limit,
          },
        );
        QueryBalanceResponse queryBalanceResponse = QueryBalanceResponse.fromJson(response.data!);
        coinEntities.addAll(queryBalanceResponse.balances);

        if( queryBalanceResponse.balances.length < limit) {
          downloadedAll = true;
        } else {
          offset += limit;
        }
      }
      return coinEntities;
    } catch (e) {
      AppLogger().log(message: 'BalancesRepository');
      rethrow;
    }
  }
}
