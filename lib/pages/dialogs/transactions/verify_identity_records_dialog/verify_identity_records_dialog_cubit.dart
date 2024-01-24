import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog_state.dart';

class VerifyIdentityRecordsDialogCubit extends TransactionCubit<VerifyIdentityRecordsDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();
  final WalletProvider walletProvider = WalletProvider();

  VerifyIdentityRecordsDialogCubit() : super(const VerifyIdentityRecordsDialogLoadingState()) {
    _init();
  }

  Future<void> sendTransaction({
    required String toAddress,
    required Coin tip,
    required List<int> recordIds,
    String? memo,
  }) async {
    txClient.requestRecordsVerification(
      senderAddress: signerAddress,
      verifierAddress: toAddress,
      tip: tip,
      recordIds: recordIds,
      fee: (state as SendTokensDialogLoadedState).executionFee,
    );
  }

  Future<void> _init() async {
    String address = walletProvider.value?.address ?? 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';
    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(address);
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgSend.interxName);

    emit(VerifyIdentityRecordsDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: address,
    ));
  }
}
