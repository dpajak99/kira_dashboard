import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/wallet.dart';

class WalletInfo extends Equatable {
  final IWallet wallet;
  final Coin? coin;

  const WalletInfo({
    required this.wallet,
    this.coin,
  });

  @override
  List<Object?> get props => [wallet, coin];
}
