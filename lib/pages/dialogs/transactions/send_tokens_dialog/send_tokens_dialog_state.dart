import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class SendTokensDialogState extends Equatable {
  const SendTokensDialogState();
}

class SendTokensDialogLoadingState extends SendTokensDialogState {
  const SendTokensDialogLoadingState();

  @override
  List<Object?> get props => [];
}

class SendTokensDialogLoadedState extends SendTokensDialogState {
  final Coin executionFee;
  final Coin initialCoin;
  final String address;

  const SendTokensDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required this.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}