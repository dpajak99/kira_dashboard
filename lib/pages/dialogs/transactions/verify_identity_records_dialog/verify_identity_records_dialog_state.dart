import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class VerifyIdentityRecordsDialogState extends Equatable {
  const VerifyIdentityRecordsDialogState();
}

class VerifyIdentityRecordsDialogLoadingState extends VerifyIdentityRecordsDialogState {
  const VerifyIdentityRecordsDialogLoadingState();

  @override
  List<Object?> get props => [];
}

class VerifyIdentityRecordsDialogLoadedState extends VerifyIdentityRecordsDialogState {
  final Coin executionFee;
  final Coin initialCoin;
  final String address;

  const VerifyIdentityRecordsDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required this.address,
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}