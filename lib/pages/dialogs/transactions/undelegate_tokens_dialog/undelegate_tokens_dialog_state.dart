
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class UndelegateTokensDialogState extends Equatable {
  const UndelegateTokensDialogState();
}

class UndelegateTokensDialogLoadingState extends UndelegateTokensDialogState {
  const UndelegateTokensDialogLoadingState();

  @override
  List<Object?> get props => [];
}

class UndelegateTokensDialogLoadedState extends UndelegateTokensDialogState {
  final Coin executionFee;
  final Coin initialCoin;
  final String address;

  const UndelegateTokensDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required this.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}