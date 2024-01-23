import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog_state.dart';

class UndelegateTokensDialogCubit extends Cubit<UndelegateTokensDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();
  final WalletProvider walletProvider = WalletProvider();


  UndelegateTokensDialogCubit() : super(const UndelegateTokensDialogLoadingState()) {
    _init();
  }

  Future<void> _init() async {
    String address = walletProvider.value?.address ?? 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';
    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(address);
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgDelegate.messageName);

    emit(UndelegateTokensDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: address,
    ));
  }
}
