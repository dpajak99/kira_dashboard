import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';

class QueryProposalsResponse extends Equatable {
  final List<ProposalEntity> proposals;

  QueryProposalsResponse.fromJson(Map<String, dynamic> json) : proposals = (json["proposals"] as List<dynamic>).map((x) => ProposalEntity.fromJson(x as Map<String, dynamic>)).toList();

  @override
  List<Object?> get props => <Object?>[proposals];
}
