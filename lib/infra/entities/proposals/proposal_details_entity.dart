import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';

class VoteEntity extends Equatable {
  final String option;
  final String proposalId;
  final String slash;
  final String voter;

  VoteEntity.fromJson(Map<String, dynamic> json)
      : option = json['option'],
        proposalId = json['proposal_id'],
        slash = json['slash'],
        voter = json['voter'];

  @override
  List<Object?> get props => <Object?>[
        option,
        proposalId,
        slash,
        voter,
      ];
}

class ProposalDetailsEntity extends Equatable {
  final ProposalEntity proposal;
  final List<VoteEntity> votes;

  ProposalDetailsEntity.fromJson(Map<String, dynamic> json)
      : proposal = ProposalEntity.fromJson(json['proposal']),
        votes = (json["votes"] as List<dynamic>).map((x) => VoteEntity.fromJson(x as Map<String, dynamic>)).toList();

  @override
  List<Object?> get props => <Object?>[proposal, votes];
}