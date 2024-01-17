import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/account/account_entity.dart';
import 'package:kira_dashboard/infra/entities/account/query_account_response.dart';

class AccountsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<AccountEntity> get(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/accounts/$address');
    QueryAccountResponse queryAccountResponse = QueryAccountResponse.fromJson(response.data!);

    return queryAccountResponse.account;
  }
}
