import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/network/interx_headers.dart';
import 'package:kira_dashboard/infra/entities/network/network_status_entity.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class NetworkRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<InterxHeaders> getStatus() async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/status',
        options: getIt<NetworkProvider>().options.copyWith(policy: CachePolicy.refreshForceCache).toOptions(),
      );
      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);
      return interxHeaders;
    } catch (e) {
      AppLogger().log(message: 'NetworkRepository');
      rethrow;
    }
  }

  Future<NetworkStatusEntity> getInfo() async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/status');
      NetworkStatusEntity networkStatusEntity = NetworkStatusEntity.fromJson(response.data!);
      return networkStatusEntity;
    } catch (e) {
      AppLogger().log(message: 'NetworkStatusEntity');
      rethrow;
    }
  }
}
