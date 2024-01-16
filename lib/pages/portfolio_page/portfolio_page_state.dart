import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/models/undelegation.dart';
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

  PortfolioPageState({
    required super.isLoading,
    this.balance = const <Coin>[],
    this.delegations = const <Delegation>[],
    this.undelegations = const <Undelegation>[],
    this.inboundVerificationRequests = const <VerificationRequest>[],
    this.outboundVerificationRequests = const <VerificationRequest>[],
    this.transactions = const <Transaction>[],
    IdentityRecords? identityRecords,
  }) : identityRecords = identityRecords ?? IdentityRecords();

  @override
  List<Object?> get props => <Object?>[balance, identityRecords, delegations, undelegations, inboundVerificationRequests, outboundVerificationRequests];
}
