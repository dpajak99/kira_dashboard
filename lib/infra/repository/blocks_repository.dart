import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/entities/blocks/query_blocks_response.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class BlocksRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<BlockEntity>> getAll() async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/blocks');
      QueryBlocksResponse queryBlocksResponse = QueryBlocksResponse.fromJson(response.data!);

      return queryBlocksResponse.blockMetas;
    } catch (e) {
      AppLogger().log(message: 'BlocksRepository');
      rethrow;
    }
  }
}
