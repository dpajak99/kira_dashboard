import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';

class DelegateTokensDialogCubit extends TransactionCubit<DelegateTokensDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();
  final WalletProvider walletProvider = WalletProvider();

  final String validatorAddress;

  DelegateTokensDialogCubit({
    required this.validatorAddress,
  }) : super(const DelegateTokensDialogLoadingState()) {
    _init();
  }

  Future<void> sendTransaction({
    required List<Coin> amounts,
    String? memo,
  }) async {
    txClient.delegateTokens(
      delegatorAddress: signerAddress,
      validatorAddress: validatorAddress,
      amounts: amounts,
      fee: (state as DelegateTokensDialogLoadedState).executionFee,
    );
  }

  Future<void> _init() async {
    String address = walletProvider.value?.address ?? 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';
    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(address);
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgDelegate.interxName);

    emit(DelegateTokensDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: address,
    ));
  }
}
