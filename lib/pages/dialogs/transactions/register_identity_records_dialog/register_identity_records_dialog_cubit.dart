
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';

class RegisterIdentityRecordsDialogCubit extends TransactionCubit<RegisterIdentityRecordsDialogState> {
  final BalancesService balancesService = BalancesService();
  final TokensService tokensService = TokensService();

  RegisterIdentityRecordsDialogCubit() : super(RegisterIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address)) {
    _init();
  }

  Future<void> sendTransaction({
    required List<IdentityInfoEntry> identityInfoEntries,
    String? memo,
  }) async {
    txClient.registerIdentityRecords(
      senderAddress: signerAddress,
      identityInfoEntries: identityInfoEntries,
      fee: (state as RegisterIdentityRecordsDialogLoadedState).executionFee,
    );
  }

  Future<void> _init() async {
    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(state.address);
    Coin executionFee = await tokensService.getExecutionFeeForMessage(MsgDelegate.interxName);

    emit(RegisterIdentityRecordsDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: state.address,
    ));
  }
}
