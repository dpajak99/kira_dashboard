import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';
import 'package:kira_dashboard/infra/entities/staking/query_delegations_response.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class DelegationsRepository extends ApiRepository {
  Future<List<DelegationEntity>> getAll(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/delegations',
        queryParameters: {
          'delegatorAddress': address,
          ...paginatedRequest.toJson(),
        },
      );
      QueryDelegationsResponse queryDelegationsResponse = QueryDelegationsResponse.fromJson(response.data!);

      return queryDelegationsResponse.delegations;
    } catch (e) {
      AppLogger().log(message: 'DelegationsRepository');
      rethrow;
    }
  }
}
