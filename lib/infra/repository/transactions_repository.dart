import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/block_transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/query_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/query_block_transactions_response.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class TransactionsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<TransactionEntity>> getUserTransactions(String address) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/transactions',
        queryParameters: <String, dynamic>{'address': address},
      );
      QueryTransactionsResponse queryTransactionsResponse = QueryTransactionsResponse.fromJson(response.data!);

      return queryTransactionsResponse.transactions;
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }

  Future<List<BlockTransactionEntity>> getBlockTransactions(String blockId) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('api/blocks/$blockId/transactions');
      QueryBlockTransactionsResponse queryBlockTransactionsResponse = QueryBlockTransactionsResponse.fromJson(response.data!);

      return queryBlockTransactionsResponse.transactions;
    } catch (e) {
      AppLogger().log(message: 'AccountsRepository');
      rethrow;
    }
  }
}
