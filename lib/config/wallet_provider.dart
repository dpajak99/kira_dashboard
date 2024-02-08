import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/infra/services/unsafe_wallet_service.dart';
import 'package:kira_dashboard/models/wallet.dart';

class WalletProvider extends ValueNotifier<IWallet?> {
  final UnsafeWalletService unsafeWalletService = UnsafeWalletService();

  List<IWallet> availableWallets = [];

  WalletProvider({
    IWallet? wallet,
  }) : super(wallet) {
    init();
  }

  void init() async {
    List<IWallet> wallets = await unsafeWalletService.getAvailableWallets();
    if (wallets.isEmpty) {
      return;
    }
    availableWallets = wallets;
    value = wallets.first;
  }

  void signIn(IWallet wallet) {
    value = wallet;
    availableWallets = [wallet];
    if (wallet is Wallet) {
      unsafeWalletService.saveWallet(wallet);
    }
  }

  void signOut() {
    value = null;
    availableWallets = [];
    unsafeWalletService.deleteAllWallets();
  }

  void changeWallet(IWallet wallet) {
    value = wallet;
    notifyListeners();
  }

  Wallet deriveNextWallet() {
    if (value is Wallet) {
      availableWallets.cast().sort((a, b) => b.index.compareTo(a.index));
      Wallet latestWallet = availableWallets.first as Wallet;
      Wallet newWallet = Wallet(
        index: latestWallet.index + 1,
        bip44: latestWallet.bip44,
        derivedBip44: latestWallet.nextAccount(),
      );
      unsafeWalletService.saveWallet(newWallet);
      availableWallets.add(newWallet);
      notifyListeners();
      return newWallet;
    } else {
      throw Exception('Cannot derive next wallet from mnemonic');
    }
  }

  bool get isSignedIn => value != null;
}
