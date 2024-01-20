import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/models/wallet.dart';

class WalletProvider extends ValueNotifier<Wallet?> {
  WalletProvider({
    Wallet? wallet,
  }) : super(wallet);

  void signIn(Wallet wallet) {
    value = wallet;
  }
}