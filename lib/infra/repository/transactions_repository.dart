import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/query_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';

class TransactionsRepository {
  final Dio httpClient = DioForBrowser(BaseOptions(
    baseUrl: 'http://65.108.86.252:11000/',
  ));

  Future<List<TransactionEntity>> getAll(String address) async {
    Response<Map<String, dynamic>> response = await httpClient.get(
      '/api/transactions',
      queryParameters: <String, dynamic>{'address': address},
    );
    QueryTransactionsResponse queryTransactionsResponse = QueryTransactionsResponse.fromJson(response.data!);

    return queryTransactionsResponse.transactions;
  }
}
