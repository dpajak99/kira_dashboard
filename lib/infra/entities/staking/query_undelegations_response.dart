import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';

class QueryUndelegationsResponse extends Equatable {
  final List<UndelegationEntity> undelegations;

  const QueryUndelegationsResponse({
    required this.undelegations,
  });

  factory QueryUndelegationsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> undelegationsList = json['undelegations'] != null ? json['undelegations'] as List<dynamic> : List<dynamic>.empty();

    return QueryUndelegationsResponse(
      undelegations: undelegationsList.map((dynamic e) => UndelegationEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[undelegations];
}
