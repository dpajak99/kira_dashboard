import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/entities/blocks/query_blocks_response.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlocksRepository extends ApiRepository {
  Future<List<BlockEntity>> getPage(PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/blocks',
        queryParameters: paginatedRequest.toJson(),
      );
      QueryBlocksResponse queryBlocksResponse = QueryBlocksResponse.fromJson(response.data!);

      return queryBlocksResponse.blockMetas;
    } catch (e) {
      AppLogger().log(message: 'BlocksRepository');
      rethrow;
    }
  }

  Future<BlockDetailsEntity> getDetails(String blockHeight) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/blocks/$blockHeight',
      );
      BlockDetailsEntity blockDetailsEntity = BlockDetailsEntity.fromJson(response.data!);

      return blockDetailsEntity;
    } catch (e) {
      AppLogger().log(message: 'BlocksRepository');
      rethrow;
    }
  }
}
