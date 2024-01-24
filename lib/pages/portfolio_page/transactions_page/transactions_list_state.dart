import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class TransactionsListState extends PageState {
  final int pageSize = 10;
  final List<Transaction> transactions;

  const TransactionsListState({
    this.transactions = const <Transaction>[],
    required super.isLoading,
  });

  TransactionsListState copyWith({
    bool? isLoading,
    List<Transaction>? transactions,
  }) {
    return TransactionsListState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [transactions, isLoading];
}
