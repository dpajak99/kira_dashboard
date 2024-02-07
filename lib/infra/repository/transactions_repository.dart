import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/transactions/block_transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/broadcast_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/query_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/query_block_transactions_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/transaction_result_entity.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/exceptions/internal_broadcast_exception.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class TransactionsRepository extends ApiRepository {
  Future<BroadcastResponse> broadcastTransaction(Map<String, dynamic> body) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.post(
        '/api/kira/txs',
        data: body,
      );
      BroadcastResponse broadcastResponse = BroadcastResponse.fromJson(response.data!);
      InternalBroadcastException? checkException = InternalBroadcastException.fromResponse(response, broadcastResponse.checkTx);
      InternalBroadcastException? deliverException = InternalBroadcastException.fromResponse(response, broadcastResponse.checkTx);

      if(checkException != null || deliverException != null) {
        throw checkException ?? deliverException!;
      }

      return broadcastResponse;
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }

  Future<PaginatedResponseWrapper<TransactionEntity>> getUserTransactionsPage(String address, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/transactions',
        queryParameters: <String, dynamic>{
          'address': address,
          ...paginatedRequest.toJson(),
        },
      );
      QueryTransactionsResponse queryTransactionsResponse = QueryTransactionsResponse.fromJson(response.data!);

      return PaginatedResponseWrapper<TransactionEntity>(
        total: response.data!['total_count'] as int,
        items: queryTransactionsResponse.transactions,
      );
    } catch (e) {
      AppLogger().log(message: 'TransactionsRepository');
      rethrow;
    }
  }

  Future<PaginatedResponseWrapper<BlockTransactionEntity>> getBlockTransactions(String blockId, PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/blocks/$blockId/transactions',
        queryParameters: paginatedRequest.toJson(),
      );
      QueryBlockTransactionsResponse queryBlockTransactionsResponse = QueryBlockTransactionsResponse.fromJson(response.data!);

      return PaginatedResponseWrapper<BlockTransactionEntity>(
        total: int.parse(response.data!['pagination']!['total']),
        items: queryBlockTransactionsResponse.transactions,
      );
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
