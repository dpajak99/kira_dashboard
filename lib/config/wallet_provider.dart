import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/infra/services/unsafe_wallet_service.dart';
import 'package:kira_dashboard/models/wallet.dart';

class WalletProvider extends ValueNotifier<Wallet?> {
  final UnsafeWalletService unsafeWalletService = UnsafeWalletService();

  List<Wallet> availableWallets = [];

  WalletProvider({
    Wallet? wallet,
  }) : super(wallet) {
    init();
  }

  void init() async {
    List<Wallet> wallets = await unsafeWalletService.getAvailableWallets();
    if (wallets.isEmpty) {
      return;
    }
    signIn(wallets.first);
    availableWallets = wallets;
  }

  void signIn(Wallet wallet) {
    value = wallet;
    unsafeWalletService.saveWallet(wallet);
  }

  void signOut() {
    value = null;
    availableWallets = [];
    unsafeWalletService.deleteAllWallets();
  }

  void changeWallet(Wallet wallet) {
    value = wallet;
    notifyListeners();
  }

  void deriveNextWallet() {
    availableWallets.sort((a, b) => b.index.compareTo(a.index));
    Wallet latestWallet = availableWallets.first;
    Wallet newWallet = Wallet(
      index: latestWallet.index + 1,
      bip44: latestWallet.bip44,
      derivedBip44: latestWallet.nextAccount(),
    );
    unsafeWalletService.saveWallet(newWallet);
    availableWallets.add(newWallet);
    notifyListeners();
  }

  bool get isSignedIn => value != null;
}
