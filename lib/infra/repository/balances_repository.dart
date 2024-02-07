import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/balances/query_balance_response.dart';
import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BalancesRepository extends ApiRepository {
  Future<PaginatedResponseWrapper<CoinEntity>> getPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/balances/$address',
        queryParameters: paginatedRequest.toJson(),
      );
      QueryBalanceResponse queryBalanceResponse = QueryBalanceResponse.fromJson(response.data!);
      PaginatedResponseWrapper<CoinEntity> paginatedResponseWrapper = PaginatedResponseWrapper(
        total: int.parse(response.data!['pagination']!['total']),
        items: queryBalanceResponse.balances,
      );
      return paginatedResponseWrapper;
    } catch (e) {
      AppLogger().log(message: 'BalancesRepository');
      rethrow;
    }
  }

  Future<CoinEntity?> getByDenom(String address, String denom) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/balances/$address',
        queryParameters: {'tokens': denom},
      );
      QueryBalanceResponse queryBalanceResponse = QueryBalanceResponse.fromJson(response.data!);
      return queryBalanceResponse.balances.firstOrNull;
    } catch (e) {
      AppLogger().log(message: 'BalancesRepository');
      rethrow;
    }
  }
}
