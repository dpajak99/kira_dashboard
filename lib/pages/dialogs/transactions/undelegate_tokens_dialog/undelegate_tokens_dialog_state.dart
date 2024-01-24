
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class UndelegateTokensDialogState extends Equatable {
  final String address;

  const UndelegateTokensDialogState({required this.address});
}

class UndelegateTokensDialogLoadingState extends UndelegateTokensDialogState {
  const UndelegateTokensDialogLoadingState({required super.address});

  @override
  List<Object?> get props => [address];
}

class UndelegateTokensDialogLoadedState extends UndelegateTokensDialogState {
  final Coin executionFee;
  final Coin initialCoin;


  const UndelegateTokensDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required super.address
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}