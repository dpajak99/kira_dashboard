import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/identity_records.dart';

class VerificationRequest extends Equatable {
  final String id;
  final String address;
  final DateTime lastRecordEditDate;
  final List<IdentityRecord> records;
  final Coin tip;
  final String verifier;

  const VerificationRequest({
    required this.id,
    required this.address,
    required this.lastRecordEditDate,
    required this.records,
    required this.tip,
    required this.verifier,
  });

  @override
  List<Object?> get props => [id, address, lastRecordEditDate, records, tip, verifier];
}
