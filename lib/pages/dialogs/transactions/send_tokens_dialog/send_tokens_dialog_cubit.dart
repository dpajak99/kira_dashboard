import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';

class SendTokensDialogCubit extends TransactionCubit<SendTokensDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();

  final Coin? initialCoin;

  SendTokensDialogCubit({
    this.initialCoin,
  }) : super(SendTokensDialogLoadingState(address: getIt<WalletProvider>().value!.address)) {
    _init();
  }

  Future<void> sendTransaction({
    required String toAddress,
    required List<Coin> amounts,
    String? memo,
  }) async {
    txClient.sendTokens(
      fromAddress: signerAddress,
      toAddress: toAddress,
      amounts: amounts,
      fee: (state as SendTokensDialogLoadedState).executionFee,
    );
  }

  Future<void> _init() async {
    Coin defaultCoinBalance = initialCoin ?? await balancesService.getDefaultCoinBalance(state.address);
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgSend.interxName);

    emit(SendTokensDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: state.address,
    ));
  }
}
