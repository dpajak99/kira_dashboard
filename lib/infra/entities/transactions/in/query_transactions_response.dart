import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/transaction_entity.dart';

class QueryTransactionsResponse extends Equatable {
  final List<TransactionEntity> transactions;

  const QueryTransactionsResponse({
    required this.transactions,
  });

  factory QueryTransactionsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> transactionsList = json['transactions'] != null ? json['transactions'] as List<dynamic> : List<dynamic>.empty();

    return QueryTransactionsResponse(
      transactions: transactionsList.map((dynamic e) => TransactionEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[transactions];
}
