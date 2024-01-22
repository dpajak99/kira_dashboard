import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class PortfolioPageState extends PageState {
  final List<Coin> balance;
  final IdentityRecords identityRecords;
  final List<Delegation> delegations;
  final List<Undelegation> undelegations;
  final List<VerificationRequest> inboundVerificationRequests;
  final List<VerificationRequest> outboundVerificationRequests;
  final List<Transaction> transactions;
  final Validator? validator;
  final bool isMyWallet;

  PortfolioPageState({
    required super.isLoading,
    required this.isMyWallet,
    this.balance = const <Coin>[],
    this.delegations = const <Delegation>[],
    this.undelegations = const <Undelegation>[],
    this.inboundVerificationRequests = const <VerificationRequest>[],
    this.outboundVerificationRequests = const <VerificationRequest>[],
    this.transactions = const <Transaction>[],
    IdentityRecords? identityRecords,
    this.validator,
  }) : identityRecords = identityRecords ?? IdentityRecords();

  PortfolioPageState copyWith({
    bool? isLoading,
    List<Coin>? balance,
    IdentityRecords? identityRecords,
    List<Delegation>? delegations,
    List<Undelegation>? undelegations,
    List<VerificationRequest>? inboundVerificationRequests,
    List<VerificationRequest>? outboundVerificationRequests,
    List<Transaction>? transactions,
    Validator? validator,
    bool? isMyWallet,
  }) {
    return PortfolioPageState(
      isLoading: isLoading ?? this.isLoading,
      balance: balance ?? this.balance,
      identityRecords: identityRecords ?? this.identityRecords,
      delegations: delegations ?? this.delegations,
      undelegations: undelegations ?? this.undelegations,
      inboundVerificationRequests: inboundVerificationRequests ?? this.inboundVerificationRequests,
      outboundVerificationRequests: outboundVerificationRequests ?? this.outboundVerificationRequests,
      transactions: transactions ?? this.transactions,
      validator: validator ?? this.validator,
      isMyWallet: isMyWallet ?? this.isMyWallet,
    );
  }

  @override
  List<Object?> get props => <Object?>[isMyWallet, balance, identityRecords, validator, delegations, undelegations, inboundVerificationRequests, outboundVerificationRequests];
}
