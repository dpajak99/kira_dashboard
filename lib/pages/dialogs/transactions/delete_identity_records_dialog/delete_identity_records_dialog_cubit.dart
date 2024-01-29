import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class DeleteIdentityRecordsDialogCubit extends RefreshablePageCubit<DeleteIdentityRecordsDialogState> with TransactionMixin {
  final BalancesService balancesService = BalancesService();
  final TransactionsService transactionsService = TransactionsService();

  DeleteIdentityRecordsDialogCubit() : super(DeleteIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address));

  @override
  Future<void> reload() async {
    emit((DeleteIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address)));

    Coin executionFee = await transactionsService.getExecutionFeeForMessage(MsgSend.interxName);

    emit(DeleteIdentityRecordsDialogLoadedState(
      executionFee: executionFee,
      address: state.address,
    ));
  }

  Future<void> sendTransaction({
    required List<String> keys,
    String? memo,
  }) async {
    txClient.deleteIdentityRecords(
      senderAddress: signerAddress,
      keys: keys,
      fee: (state as DeleteIdentityRecordsDialogLoadedState).executionFee,
    );
  }
}
