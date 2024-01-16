import 'package:equatable/equatable.dart';

class VerificationRequestEntity extends Equatable {
  final String address;
  final String id;
  final String lastRecordEditDate;
  final List<String> recordIds;
  final String tip;
  final String verifier;

  const VerificationRequestEntity({
    required this.address,
    required this.id,
    required this.lastRecordEditDate,
    required this.recordIds,
    required this.tip,
    required this.verifier,
  });

  factory VerificationRequestEntity.fromJson(Map<String, dynamic> json) {
    return VerificationRequestEntity(
      address: json['address'] as String,
      id: json['id'] as String,
      lastRecordEditDate: json['lastRecordEditDate'] as String,
      recordIds: (json['recordIds'] as List<dynamic>).cast(),
      tip: json['tip'] as String,
      verifier: json['verifier'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[address, id, lastRecordEditDate, recordIds, tip, verifier];
}