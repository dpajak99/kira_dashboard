import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_details_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/models/proposal.dart';

class ProposalDetails extends Equatable {
  final Proposal proposal;
  final List<Vote> votes;

  const ProposalDetails({
    required this.proposal,
    required this.votes,
  });

  List<Vote> get yesVotes => votes.where((Vote vote) => vote.option == VoteOption.yes).toList();

  List<Vote> get noVotes => votes.where((Vote vote) => vote.option == VoteOption.no).toList();

  int get totalVoters => proposal.voters;

  double get yesVotesPercentage => yesVotes.length / proposal.voters;

  double get noVotesPercentage => noVotes.length / proposal.voters;

  double get unknownVotePercentage => 1 - yesVotesPercentage - noVotesPercentage;

  @override
  List<Object?> get props => <Object?>[proposal, votes];
}

class Vote extends Equatable {
  final VoteOption option;
  final String proposalId;
  final String slash;
  final String voter;

  Vote.fromJson(Map<String, dynamic> json)
      : option = json['option'],
        proposalId = json['proposal_id'],
        slash = json['slash'],
        voter = json['voter'];

  Vote.fromEntity(VoteEntity voteEntity)
      : option = VoteOption.fromString(voteEntity.option),
        proposalId = voteEntity.proposalId,
        slash = voteEntity.slash,
        voter = voteEntity.voter;

  @override
  List<Object?> get props => <Object?>[
        option,
        proposalId,
        slash,
        voter,
      ];
}
