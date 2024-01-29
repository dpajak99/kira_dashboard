import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class DelegateTokensDialogCubit extends RefreshablePageCubit<DelegateTokensDialogState> with TransactionMixin {
  final BalancesService balancesService = BalancesService();
  final TransactionsService transactionsService = TransactionsService();

  final String validatorAddress;

  DelegateTokensDialogCubit({
    required this.validatorAddress,
  }) : super(DelegateTokensDialogLoadingState(address: getIt<WalletProvider>().value!.address));

  @override
  Future<void> reload() async {
    emit(DelegateTokensDialogLoadingState(address: getIt<WalletProvider>().value!.address));

    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(state.address);
    Coin executionFee = await transactionsService.getExecutionFeeForMessage(MsgDelegate.interxName);

    emit(DelegateTokensDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: state.address,
    ));
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
}
