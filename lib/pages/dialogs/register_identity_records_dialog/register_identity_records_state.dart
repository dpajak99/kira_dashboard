
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class RegisterIdentityRecordsDialogState extends Equatable {
  const RegisterIdentityRecordsDialogState();
}

class RegisterIdentityRecordsDialogLoadingState extends RegisterIdentityRecordsDialogState {
  const RegisterIdentityRecordsDialogLoadingState();

  @override
  List<Object?> get props => [];
}

class RegisterIdentityRecordsDialogLoadedState extends RegisterIdentityRecordsDialogState {
  final Coin executionFee;
  final Coin initialCoin;
  final String address;

  const RegisterIdentityRecordsDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required this.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}