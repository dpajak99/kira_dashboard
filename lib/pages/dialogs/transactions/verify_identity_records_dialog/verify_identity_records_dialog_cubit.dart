import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog_state.dart';

class VerifyIdentityRecordsDialogCubit extends TransactionCubit<VerifyIdentityRecordsDialogState> {
  final BalancesService balancesService = BalancesService();
  final TransactionsService transactionsService = TransactionsService();

  VerifyIdentityRecordsDialogCubit() : super(VerifyIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address)) {
    _init();
  }

  Future<void> sendTransaction({
    required String toAddress,
    required Coin tip,
    required List<String> recordIds,
    String? memo,
  }) async {
    txClient.requestRecordsVerification(
      senderAddress: signerAddress,
      verifierAddress: toAddress,
      tip: tip,
      recordIds: recordIds,
      fee: (state as VerifyIdentityRecordsDialogLoadedState).executionFee,
    );
  }

  Future<void> _init() async {
    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(state.address);
    Coin executionFee = await transactionsService.getExecutionFeeForMessage(MsgSend.interxName);

    emit(VerifyIdentityRecordsDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: state.address,
    ));
  }
}
