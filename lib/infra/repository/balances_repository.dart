import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BalancesRepository extends ApiRepository {
  Future<List<CoinEntity>> getPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/balances/$address',
        queryParameters: paginatedRequest.toJson(),
      );
      QueryBalanceResponse queryBalanceResponse = QueryBalanceResponse.fromJson(response.data!);

      return queryBalanceResponse.balances;
    } catch (e) {
      AppLogger().log(message: 'BalancesRepository');
      rethrow;
    }
  }
}
