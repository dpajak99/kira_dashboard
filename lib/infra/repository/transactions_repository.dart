import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/block_transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/query_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/query_block_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/transaction_result_entity.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class TransactionsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<void> broadcastTransaction(Map<String, dynamic> body) async {
    try {
      await httpClient.post(
        '/api/kira/txs',
        data: body,
      );
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }

  Future<List<TransactionEntity>> getUserTransactionsPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/transactions',
        queryParameters: <String, dynamic>{
          'address': address,
          ...paginatedRequest.toJson(),
        },
      );
      QueryTransactionsResponse queryTransactionsResponse = QueryTransactionsResponse.fromJson(response.data!);

      return queryTransactionsResponse.transactions;
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }

  Future<List<BlockTransactionEntity>> getBlockTransactions(String blockId, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/blocks/$blockId/transactions',
        queryParameters: paginatedRequest.toJson(),
      );
      QueryBlockTransactionsResponse queryBlockTransactionsResponse = QueryBlockTransactionsResponse.fromJson(response.data!);

      return queryBlockTransactionsResponse.transactions;
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }

  Future<TransactionResultEntity> getTransactionResult(String hash) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/transactions/$hash');
      TransactionResultEntity transactionResultEntity = TransactionResultEntity.fromJson(response.data!);

      return transactionResultEntity;
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }
}
