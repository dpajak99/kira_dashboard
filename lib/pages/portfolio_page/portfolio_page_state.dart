import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class PortfolioPageState extends PageState {
  final IdentityRecords identityRecords;
  final Validator? validator;
  final bool isMyWallet;

  PortfolioPageState({
    required super.isLoading,
    required this.isMyWallet,
    IdentityRecords? identityRecords,
    this.validator,
  }) : identityRecords = identityRecords ?? IdentityRecords();

  PortfolioPageState copyWith({
    bool? isLoading,
    IdentityRecords? identityRecords,
    Validator? validator,
    bool? isMyWallet,
  }) {
    return PortfolioPageState(
      isLoading: isLoading ?? this.isLoading,
      identityRecords: identityRecords ?? this.identityRecords,
      validator: validator ?? this.validator,
      isMyWallet: isMyWallet ?? this.isMyWallet,
    );
  }

  @override
  List<Object?> get props => <Object?>[isMyWallet, identityRecords, validator];
}
