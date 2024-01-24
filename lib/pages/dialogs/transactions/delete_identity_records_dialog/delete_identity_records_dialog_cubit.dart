import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog_state.dart';

class DeleteIdentityRecordsDialogCubit extends TransactionCubit<DeleteIdentityRecordsDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();

  DeleteIdentityRecordsDialogCubit() : super(DeleteIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address)) {
    _init();
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

  Future<void> _init() async {
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgSend.interxName);

    emit(DeleteIdentityRecordsDialogLoadedState(
      executionFee: executionFee,
      address: state.address,
    ));
  }
}
