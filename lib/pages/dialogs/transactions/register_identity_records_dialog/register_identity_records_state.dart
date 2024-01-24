import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class RegisterIdentityRecordsDialogState extends Equatable {
  final String address;

  const RegisterIdentityRecordsDialogState({required this.address});
}

class RegisterIdentityRecordsDialogLoadingState extends RegisterIdentityRecordsDialogState {
  const RegisterIdentityRecordsDialogLoadingState({required super.address});

  @override
  List<Object?> get props => [address];
}

class RegisterIdentityRecordsDialogLoadedState extends RegisterIdentityRecordsDialogState {
  final Coin executionFee;
  final Coin initialCoin;

  const RegisterIdentityRecordsDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required super.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}
