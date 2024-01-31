import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';

enum VoteResult {
  unknown('VOTE_RESULT_UNKNOWN'),
  passed('VOTE_RESULT_PASSED'),
  rejected('VOTE_RESULT_REJECTED'),
  rejectedWithVeto('VOTE_RESULT_REJECTED_WITH_VETO'),
  pending('VOTE_PENDING'),
  quorumNotReached('VOTE_RESULT_QUORUM_NOT_REACHED'),
  enactment('VOTE_RESULT_ENACTMENT'),
  passedWithExecFail('VOTE_RESULT_PASSED_WITH_EXEC_FAIL');

  final String name;

  const VoteResult(this.name);

  static VoteResult fromString(String name) {
    return VoteResult.values.firstWhere((e) => e.name == name);
  }
}

enum VotingStatus {
  pending,
  success,
  failure,
}

class Proposal {
  final String id;
  final String title;
  final String description;
  final VoteResult status;
  final dynamic content;
  final int voters;
  final Duration timePassed;
  final DateTime votingStartTime;
  final DateTime votingEndTime;

  Proposal({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.content,
    required this.voters,
    required this.timePassed,
    required this.votingStartTime,
    required this.votingEndTime,
  });

  factory Proposal.fromEntity(ProposalEntity entity) {
    return Proposal(
      id: entity.proposalId,
      description: entity.description,
      content: entity.content,
      title: entity.title,
      status: VoteResult.fromString(entity.result),
      voters: entity.votersCount,
      timePassed: DateTime.now().difference(DateTime.parse(entity.submitTime)),
      votingStartTime: DateTime.parse(entity.submitTime),
      votingEndTime: DateTime.parse(entity.votingEndTime),
    );
  }

  VotingStatus get simpleStatus {
    switch (status) {
      case VoteResult.passed:
        return VotingStatus.success;
      case VoteResult.rejected:
      case VoteResult.rejectedWithVeto:
      case VoteResult.quorumNotReached:
      case VoteResult.passedWithExecFail:
        return VotingStatus.failure;
      default:
        return VotingStatus.pending;
    }
  }
}
