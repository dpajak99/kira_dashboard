import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/custody.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/send_tokens_dialog/send_tokens_dialog_state.dart';

class SendTokensDialogCubit extends Cubit<SendTokensDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();
  final WalletProvider walletProvider = WalletProvider();

  final Coin? initialCoin;

  SendTokensDialogCubit({
    this.initialCoin,
  }) : super(const SendTokensDialogLoadingState()) {
    _init();
  }

  Future<void> _init() async {
    String address = walletProvider.value?.address ?? 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';
    Coin defaultCoinBalance = initialCoin ?? await balancesService.getDefaultCoinBalance(address);
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgSend.messageName);

    emit(SendTokensDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: address,
    ));
  }
}
