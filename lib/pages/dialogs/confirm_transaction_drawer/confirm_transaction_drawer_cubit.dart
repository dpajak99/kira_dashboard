import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/transaction_remote_data.dart';
import 'package:kira_dashboard/pages/dialogs/confirm_transaction_drawer/confirm_transaction_drawer_state.dart';

class ConfirmTransactionDrawerCubit extends Cubit<ConfirmTransactionDrawerState> {
  final TransactionsService transactionsService = TransactionsService();

  final String signerAddress;
  final TxMsg txMsg;
  final String memo;
  final Coin fee;

  ConfirmTransactionDrawerCubit({
    required this.signerAddress,
    required this.txMsg,
    required this.memo,
    required this.fee,
  }) : super(const ConfirmTransactionDrawerState()) {
    _init();
  }

  Future<void> _init() async {
    TransactionRemoteData transactionRemoteData = await transactionsService.getRemoteUserTransactionData(signerAddress);
    emit(ConfirmTransactionDrawerState());
  }

}
