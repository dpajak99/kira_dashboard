
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class DelegateTokensDialogState extends Equatable {
  const DelegateTokensDialogState();
}

class DelegateTokensDialogLoadingState extends DelegateTokensDialogState {
  const DelegateTokensDialogLoadingState();

  @override
  List<Object?> get props => [];
}

class DelegateTokensDialogLoadedState extends DelegateTokensDialogState {
  final Coin executionFee;
  final Coin initialCoin;
  final String address;

  const DelegateTokensDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required this.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}