import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/multistaking.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/infra/services/transactions_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_state.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/transaction_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class RegisterIdentityRecordsDialogCubit extends RefreshablePageCubit<RegisterIdentityRecordsDialogState> with TransactionMixin {
  final BalancesService balancesService = BalancesService();
  final TransactionsService transactionsService = TransactionsService();

  RegisterIdentityRecordsDialogCubit() : super(RegisterIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address));

  @override
  Future<void> reload() async {
    emit(RegisterIdentityRecordsDialogLoadingState(address: getIt<WalletProvider>().value!.address));

    Coin defaultCoinBalance = await balancesService.getDefaultCoinBalance(state.address);
    Coin executionFee = await transactionsService.getExecutionFeeForMessage(MsgDelegate.interxName);

    emit(RegisterIdentityRecordsDialogLoadedState(
      initialCoin: defaultCoinBalance,
      executionFee: executionFee,
      address: state.address,
    ));
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
}
