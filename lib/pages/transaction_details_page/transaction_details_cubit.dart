import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/transaction_result.dart';
import 'package:kira_dashboard/pages/transaction_details_page/transaction_details_state.dart';

class TransactionDetailsCubit extends Cubit<TransactionDetailsState> {
  final TransactionsService transactionsService = TransactionsService();
  final String hash;
  
  TransactionDetailsCubit({required this.hash}) : super(const TransactionDetailsState(isLoading: true)) {
    init();
  }

  Future<void> init() async {
      TransactionResult transactionResult = await transactionsService.getTransactionResult(hash);
      emit(TransactionDetailsState(isLoading: false, transactionResult: transactionResult));
  }
}