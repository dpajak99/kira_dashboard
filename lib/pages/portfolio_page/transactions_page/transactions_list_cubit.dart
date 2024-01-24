import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_list_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class TransactionsListCubit extends Cubit<TransactionsListState> {
  final TransactionsService transactionsService = TransactionsService();

  final String address;
  final bool isMyWallet;

  TransactionsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const TransactionsListState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Transaction> transactions = await transactionsService.getUserTransactionsPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, transactions: transactions));
  }
}