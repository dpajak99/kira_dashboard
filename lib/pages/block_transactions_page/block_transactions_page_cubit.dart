import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/block_transaction.dart';
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_page_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BlockTransactionsPageCubit extends ListCubit<BlockTransactionsPageState> {
  final TransactionsService transactionsService = TransactionsService();
  final NetworkListCubit networkListCubit = getIt<NetworkListCubit>();

  String? blockId;

  BlockTransactionsPageCubit({required this.blockId}) : super(const BlockTransactionsPageState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const BlockTransactionsPageState(isLoading: true));

    blockId ??= networkListCubit.state.currentNetwork?.details?.block.toString();

    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<BlockTransaction> transactions = await transactionsService.getBlockTransactionsPage(blockId!, paginatedRequest);
    emit(BlockTransactionsPageState(isLoading: false, transactions: transactions));
  }
}
