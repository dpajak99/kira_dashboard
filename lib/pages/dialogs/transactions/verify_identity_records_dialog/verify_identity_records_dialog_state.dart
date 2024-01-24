import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class VerifyIdentityRecordsDialogState extends Equatable {
  final String address;

  const VerifyIdentityRecordsDialogState({
    required this.address,
});
}

class VerifyIdentityRecordsDialogLoadingState extends VerifyIdentityRecordsDialogState {
  const VerifyIdentityRecordsDialogLoadingState({required super.address});

  @override
  List<Object?> get props => [address];
}

class VerifyIdentityRecordsDialogLoadedState extends VerifyIdentityRecordsDialogState {
  final Coin executionFee;
  final Coin initialCoin;


  const VerifyIdentityRecordsDialogLoadedState({
    required this.executionFee,
    required this.initialCoin,
    required super.address
  });

  @override
  List<Object?> get props => [executionFee, initialCoin, address];
}