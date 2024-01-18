import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/block_transaction_entity.dart';

class QueryBlockTransactionsResponse extends Equatable {
  final List<BlockTransactionEntity> transactions;

  const QueryBlockTransactionsResponse({
    required this.transactions,
  });

  factory QueryBlockTransactionsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> transactions = json['txs'] != null ? json['txs'] as List<dynamic> : List<dynamic>.empty();

    return QueryBlockTransactionsResponse(
      transactions: transactions.map((dynamic e) => BlockTransactionEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[transactions];
}
