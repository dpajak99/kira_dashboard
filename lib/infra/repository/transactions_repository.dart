import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/query_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';

class TransactionsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<TransactionEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/transactions',
      queryParameters: <String, dynamic>{'address': address},
    );
    QueryTransactionsResponse queryTransactionsResponse = QueryTransactionsResponse.fromJson(response.data!);

    return queryTransactionsResponse.transactions;
  }
}
