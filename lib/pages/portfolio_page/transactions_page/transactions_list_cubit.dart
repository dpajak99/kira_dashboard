import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class TransactionsListCubit extends PaginatedListCubit<Transaction> {
  final TransactionsService transactionsService = TransactionsService();
  final String address;

  TransactionsListCubit({
    required this.address,
  }) : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<Transaction>> getPage(PaginatedRequest paginatedRequest) {
    return transactionsService.getUserTransactionsPage(address, paginatedRequest);
  }
}