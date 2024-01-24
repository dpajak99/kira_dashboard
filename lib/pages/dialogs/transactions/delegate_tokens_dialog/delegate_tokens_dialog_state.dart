
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class DelegateTokensDialogState extends Equatable {
  final String address;

  const DelegateTokensDialogState({required this.address});
}

class DelegateTokensDialogLoadingState extends DelegateTokensDialogState {
  const DelegateTokensDialogLoadingState({required super.address});

  @override
  List<Object?> get props => [address];
}

class DelegateTokensDialogLoadedState extends DelegateTokensDialogState {
  final Coin executionFee;
  final Coin initialCoin;


  const DelegateTokensDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required super.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}