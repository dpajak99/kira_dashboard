import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class SendTokensDialogCubit extends RefreshablePageCubit<SendTokensDialogState> with TransactionMixin {
  final BalancesService balancesService = BalancesService();
  final TransactionsService transactionsService = TransactionsService();

  final Coin? initialCoin;

  SendTokensDialogCubit({
    this.initialCoin,
  }) : super(SendTokensDialogLoadingState(address: getIt<WalletProvider>().value!.address));

  @override
  Future<void> reload() async {
    emit(SendTokensDialogLoadingState(address: getIt<WalletProvider>().value!.address));

    Coin defaultCoinBalance = initialCoin ?? await balancesService.getDefaultCoinBalance(state.address);
    Coin executionFee = await transactionsService.getExecutionFeeForMessage(MsgSend.interxName);

    emit(SendTokensDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: state.address,
    ));
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
}
