import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

abstract class DeleteIdentityRecordsDialogState extends Equatable {
  final String address;

  const DeleteIdentityRecordsDialogState({
    required this.address,
});
}

class DeleteIdentityRecordsDialogLoadingState extends DeleteIdentityRecordsDialogState {
  const DeleteIdentityRecordsDialogLoadingState({required super.address});

  @override
  List<Object?> get props => [address];
}

class DeleteIdentityRecordsDialogLoadedState extends DeleteIdentityRecordsDialogState {
  final Coin executionFee;


  const DeleteIdentityRecordsDialogLoadedState({
    required this.executionFee,
    required super.address
  });

  @override
  List<Object?> get props => [executionFee, address];
}