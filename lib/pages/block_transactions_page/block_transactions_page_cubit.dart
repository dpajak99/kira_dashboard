import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/network_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/block_transaction.dart';
import 'package:kira_dashboard/models/network_status.dart';
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page_state.dart';

class BlockTransactionsPageCubit extends Cubit<BlockTransactionsPageState> {
  final TransactionsService transactionsService = TransactionsService();
  final NetworkService networkService = NetworkService();

  BlockTransactionsPageCubit() : super(const BlockTransactionsPageState(isLoading: true));

  Future<void> init(String? blockId) async {
    if( blockId == null ) {
      NetworkStatus networkStatus = await networkService.getStatus();
      blockId = networkStatus.block.toString();
    }
    List<BlockTransaction> transactions = await transactionsService.getBlockTransactions(blockId);

    emit(BlockTransactionsPageState(
      isLoading: false,
      transactions: transactions,
    ));
  }
}
