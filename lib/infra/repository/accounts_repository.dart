import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/account/account_entity.dart';
import 'package:kira_dashboard/infra/entities/account/query_account_response.dart';
import 'package:kira_dashboard/infra/entities/network/headers_wrapper.dart';
import 'package:kira_dashboard/infra/entities/network/interx_headers.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class AccountsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<AccountEntity> get(String address) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/accounts/$address');
      QueryAccountResponse queryAccountResponse = QueryAccountResponse.fromJson(response.data!);

      return queryAccountResponse.account;
    } catch (e) {
      AppLogger().log(message: 'AccountsRepository');
      rethrow;
    }
  }

  Future<HeadersWrapper<AccountEntity>> getWithHeaders(String address) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/accounts/$address',
        options: getIt<NetworkProvider>().options.copyWith(policy: CachePolicy.refreshForceCache).toOptions(),

      );
      QueryAccountResponse queryAccountResponse = QueryAccountResponse.fromJson(response.data!);
      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return HeadersWrapper<AccountEntity>(
        headers: interxHeaders,
        data: queryAccountResponse.account,
      );
    } catch (e) {
      AppLogger().log(message: 'AccountsRepository');
      rethrow;
    }
  }
}
