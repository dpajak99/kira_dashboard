import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/identity_registrar/identity_record_entity.dart';

class QueryIdentityRecordsResponse extends Equatable {
  final List<IdentityRecordEntity> records;

  const QueryIdentityRecordsResponse({
    required this.records,
  });

  factory QueryIdentityRecordsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> recordsList = json['records'] != null ? json['records'] as List<dynamic> : List<dynamic>.empty();

    return QueryIdentityRecordsResponse(
      records: recordsList.map((dynamic e) => IdentityRecordEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[records];
}
