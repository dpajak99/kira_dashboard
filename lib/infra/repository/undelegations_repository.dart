import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/staking/query_undelegations_response.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class UndelegationsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<UndelegationEntity>> getPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/undelegations',
        queryParameters: {
          'undelegatorAddress': address,
          ...paginatedRequest.toJson(),
        },
      );
      QueryUndelegationsResponse queryUndelegationsResponse = QueryUndelegationsResponse.fromJson(response.data!);

      return queryUndelegationsResponse.undelegations;
    } catch (e) {
      AppLogger().log(message: 'UndelegationsRepository');
      rethrow;
    }
  }
}
