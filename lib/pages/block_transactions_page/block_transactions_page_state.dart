import 'package:kira_dashboard/models/block_transaction.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class BlockTransactionsPageState extends PageState {
  final List<BlockTransaction> transactions;

  const BlockTransactionsPageState({
    required super.isLoading,
    this.transactions = const <BlockTransaction>[],
  });

  @override
  List<Object?> get props => <Object?>[transactions];
}
