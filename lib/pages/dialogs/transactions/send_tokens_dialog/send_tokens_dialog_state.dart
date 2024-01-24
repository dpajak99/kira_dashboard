import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class SendTokensDialogState extends Equatable {
  final String address;

  const SendTokensDialogState({required this.address});
}

class SendTokensDialogLoadingState extends SendTokensDialogState {
  const SendTokensDialogLoadingState({required super.address});

  @override
  List<Object?> get props => [address];
}

class SendTokensDialogLoadedState extends SendTokensDialogState {
  final Coin executionFee;
  final Coin initialCoin;


  const SendTokensDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required super.address
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}