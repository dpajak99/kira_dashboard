import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/block_transaction.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlockTransactionsListCubit extends PaginatedListCubit<BlockTransaction> {
  final TransactionsService transactionsService = TransactionsService();

  String? blockId;

  BlockTransactionsListCubit({required this.blockId}) : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<BlockTransaction>> getPage(PaginatedRequest paginatedRequest) async {
    blockId ??= networkListCubit.state.currentNetwork?.details?.block.toString();

    return transactionsService.getBlockTransactionsPage(blockId!, paginatedRequest);
  }
}
