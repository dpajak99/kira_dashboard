import 'package:kira_dashboard/models/transaction_result.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class TransactionDetailsState extends PageState {
  final TransactionResult? transactionResult;

  const TransactionDetailsState({
    required super.isLoading,
    this.transactionResult,
  });

  @override
  List<Object?> get props => [transactionResult];
}
