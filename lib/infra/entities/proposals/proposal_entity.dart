import 'package:equatable/equatable.dart';

class ProposalEntity extends Equatable {
  final String proposalId;
  final String title;
  final String description;
  final dynamic content;
  final String submitTime;
  final String votingEndTime;
  final String enactmentEndTime;
  final String minVotingEndBlockHeight;
  final String minEnactmentEndBlockHeight;
  final String execResult;
  final String result;
  final int votersCount;
  final int votesCount;
  final String quorum;
  final String metaData;

  ProposalEntity.fromJson(Map<String, dynamic> json)
      : proposalId = json['proposal_id'],
        title = json['title'],
        description = json['description'],
        content = json['content'],
        submitTime = json['submit_time'],
        votingEndTime = json['voting_end_time'],
        enactmentEndTime = json['enactment_end_time'],
        minVotingEndBlockHeight = json['min_voting_end_block_height'],
        minEnactmentEndBlockHeight = json['min_enactment_end_block_height'],
        execResult = json['exec_result'],
        result = json['result'],
        votersCount = json['voters_count'],
        votesCount = json['votes_count'],
        quorum = json['quorum'],
        metaData = json['meta_data'];

  @override
  List<Object?> get props => <Object?>[
    proposalId,
    title,
    description,
    content,
    submitTime,
    votingEndTime,
    enactmentEndTime,
    minVotingEndBlockHeight,
    minEnactmentEndBlockHeight,
    execResult,
    result,
    votersCount,
    votesCount,
    quorum,
    metaData,
  ];
}