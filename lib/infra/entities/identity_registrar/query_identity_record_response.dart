import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';

class QueryIdentityRecordResponse extends Equatable {
  final IdentityRecordEntity identityRecord;

  const QueryIdentityRecordResponse({required this.identityRecord,});

  factory QueryIdentityRecordResponse.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordResponse(
      identityRecord: IdentityRecordEntity.fromJson(json['record'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[identityRecord];
}