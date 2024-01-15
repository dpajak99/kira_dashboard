import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';

class QueryDelegationsResponse extends Equatable {
  final List<DelegationEntity> delegations;

  const QueryDelegationsResponse({
    required this.delegations,
  });

  factory QueryDelegationsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> delegationsList = json['delegations'] != null ? json['delegations'] as List<dynamic> : List<dynamic>.empty();

    return QueryDelegationsResponse(
      delegations: delegationsList.map((dynamic e) => DelegationEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[delegations];
}
