import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/infra/services/unsafe_wallet_service.dart';
import 'package:kira_dashboard/models/wallet.dart';

class WalletProvider extends ValueNotifier<Wallet?> {
  final UnsafeWalletService unsafeWalletService = UnsafeWalletService();

  WalletProvider({
    Wallet? wallet,
  }) : super(wallet) {
    init();
  }

  void init() async {
    Wallet? wallet = await unsafeWalletService.getWallet();
    value = wallet;
  }

  void signIn(Wallet wallet) {
    value = wallet;
    unsafeWalletService.saveWallet(wallet);
  }
}