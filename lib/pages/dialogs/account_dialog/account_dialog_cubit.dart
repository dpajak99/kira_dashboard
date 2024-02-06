import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/infra/services/balances_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/account_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/wallet_info.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class AccountDialogCubit extends RefreshablePageCubit<AccountDialogState> {
  final WalletProvider walletProvider = getIt<WalletProvider>();
  final BalancesService balancesService = BalancesService();

  AccountDialogCubit() : super(const AccountDialogState(isLoading: true)) {
    walletProvider.addListener(_updateWallet);
  }

  @override
  Future<void> close() {
    walletProvider.removeListener(_updateWallet);
    return super.close();
  }

  @override
  Future<void> reload() async {
    emit(state.copyWith(isLoading: true, selectedWallet: walletProvider.value));
    List<WalletInfo> emptyWalletInfos = walletProvider.availableWallets.map((e) => WalletInfo(wallet: e)).toList();
    emit(state.copyWith(walletInfos: emptyWalletInfos, selectedWallet: walletProvider.value, isLoading: true));
    List<WalletInfo> walletInfos = [];

    for (Wallet wallet in walletProvider.availableWallets) {
      Coin coin = await balancesService.getDefaultCoinBalance(wallet.address);
      walletInfos.add(WalletInfo(wallet: wallet, coin: coin));
    }
    emit(state.copyWith(walletInfos: List.from(walletInfos), selectedWallet: walletProvider.value, isLoading: false));
  }

  void signIn(Wallet wallet) {
    walletProvider.signIn(wallet);
  }

  void signOut() {
    walletProvider.signOut();
  }

  Future<void> deriveNextWallet() async {
    Wallet newWallet = walletProvider.deriveNextWallet();
    emit(state.copyWith(walletInfos: [...state.walletInfos, WalletInfo(wallet: newWallet)]));

    Coin coin = await balancesService.getDefaultCoinBalance(newWallet.address);
    List<WalletInfo> walletInfos = state.walletInfos;
    walletInfos.removeWhere((WalletInfo e) => e.wallet == newWallet);

    walletInfos.add(WalletInfo(wallet: newWallet, coin: coin));
    emit(state.copyWith(walletInfos: List.from(walletInfos)));
  }

  void _updateWallet() {
    if (walletProvider.value != state.selectedWallet) {
      emit(state.copyWith(selectedWallet: walletProvider.value));
    }
  }
}
