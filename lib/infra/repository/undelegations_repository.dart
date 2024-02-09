import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/staking/query_undelegations_response.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class UndelegationsRepository extends ApiRepository {

  Future<PaginatedResponseWrapper<UndelegationEntity>> getPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/undelegations',
        queryParameters: {
          'undelegatorAddress': address,
          ...paginatedRequest.toJson(),
        },
      );
      QueryUndelegationsResponse queryUndelegationsResponse = QueryUndelegationsResponse.fromJson(response.data!);

      return PaginatedResponseWrapper<UndelegationEntity>(
        total: int.parse(response.data?['pagination']?['total'] ?? '0'),
        items: queryUndelegationsResponse.undelegations,
      );
    } catch (e) {
      AppLogger().log(message: 'UndelegationsRepository');
      rethrow;
    }
  }
}
