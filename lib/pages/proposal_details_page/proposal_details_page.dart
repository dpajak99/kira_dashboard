import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:json_view/json_view.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/pages/proposal_details_page/proposal_details_page_cubit.dart';
import 'package:kira_dashboard/pages/proposal_details_page/proposal_details_page_state.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/linear_proportions.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:markdown_widget/markdown_widget.dart';

@RoutePage()
class ProposalDetailsPage extends StatefulWidget {
  final String proposalId;

  const ProposalDetailsPage({
    @PathParam('proposalId') required this.proposalId,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ProposalDetailsPageState();
}

class _ProposalDetailsPageState extends State<ProposalDetailsPage> {
  late final ProposalDetailsPageCubit proposalDetailsPageCubit = ProposalDetailsPageCubit(proposalId: widget.proposalId);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalDetailsPageCubit, ProposalDetailsPageState>(
      bloc: proposalDetailsPageCubit,
      builder: (BuildContext context, ProposalDetailsPageState state) {
        if (state.isLoading) {
          return const Center(
            child: SizedBox(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                color: Color(0xff2f8af5),
                strokeWidth: 2,
              ),
            ),
          );
        }
        return PageScaffold(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Proposal #${widget.proposalId}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff6c86ad),
                          ),
                        ),
                        Text(
                          state.proposalDetails!.proposal.title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xfffbfbfb),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _StatusChip(voteResult: state.proposalDetails!.proposal.status),
                            const SizedBox(width: 8),
                            Text(
                              switch (state.proposalDetails!.proposal.simpleStatus) {
                                VotingStatus.pending => 'Voting ends ${DateFormat('d MMM y, HH:mm').format(state.proposalDetails!.proposal.votingEndTime)}',
                                VotingStatus.success => 'Voting ended ${DateFormat('d MMM y, HH:mm').format(state.proposalDetails!.proposal.votingEndTime)}',
                                VotingStatus.failure => 'Voting ended ${DateFormat('d MMM y, HH:mm').format(state.proposalDetails!.proposal.votingEndTime)}',
                              },
                              style: TextStyle(
                                fontSize: 12,
                                color: switch (state.proposalDetails!.proposal.simpleStatus) {
                                  VotingStatus.pending => const Color(0xff6c86ad),
                                  VotingStatus.success => const Color(0xff35b15f),
                                  VotingStatus.failure => const Color(0xfff12e1f),
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 16)),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: const Text(
                                  'For',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff6c86ad),
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                subtitle: Text(
                                    '${state.proposalDetails!.yesVotes.length} / ${state.proposalDetails!.totalVoters} (${state.proposalDetails!.yesVotesPercentage * 100}%)'),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: const Text(
                                  'Against',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff6c86ad),
                                  ),
                                ),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                subtitle: Text(
                                    '${state.proposalDetails!.noVotes.length} / ${state.proposalDetails!.totalVoters} (${state.proposalDetails!.noVotesPercentage * 100}%)'),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        LinearProportions(
                          proportions: [
                            ProportionValue(
                              value: state.proposalDetails?.yesVotesPercentage ?? 0,
                              color: const Color(0xee35b15f),
                            ),
                            ProportionValue(
                              value: state.proposalDetails?.noVotesPercentage ?? 0,
                              color: const Color(0xfff12e1f),
                            ),
                            ProportionValue(
                              value: state.proposalDetails?.unknownVotePercentage ?? 0,
                              color: const Color(0xff6c86ad),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 64)),
            const SliverToBoxAdapter(
              child:  Text(
                'Description',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xfffbfbfb),
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 20)),
            SliverToBoxAdapter(
              child: CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.proposalDetails!.proposal.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Color(0xfffbfbfb),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MarkdownWidget(
                      data: state.proposalDetails!.proposal.description,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            SliverToBoxAdapter(
              child: CustomCard(
                title: 'Details',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xff06070a),
                  ),
                  child: JsonView(
                    json: state.proposalDetails!.proposal.content,
                    shrinkWrap: true,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final VoteResult voteResult;

  const _StatusChip({required this.voteResult});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (voteResult) {
            VoteResult.unknown => const Color(0x29f12e1f),
            VoteResult.passed => const Color(0x2935b15f),
            VoteResult.rejected => const Color(0x29f12e1f),
            VoteResult.rejectedWithVeto => const Color(0x29f12e1f),
            VoteResult.pending => const Color(0x296c86ad),
            VoteResult.quorumNotReached => const Color(0x29f12e1f),
            VoteResult.enactment => const Color(0x2989ffb0),
            VoteResult.passedWithExecFail => const Color(0x29f12e1f),
          },
        ),
        child: Text(
          switch (voteResult) {
            VoteResult.unknown => 'Unknown',
            VoteResult.passed => 'Passed',
            VoteResult.rejected => 'Rejected',
            VoteResult.rejectedWithVeto => 'Rejected with veto',
            VoteResult.pending => 'Pending',
            VoteResult.quorumNotReached => 'Quorum not reached',
            VoteResult.enactment => 'Enactment',
            VoteResult.passedWithExecFail => 'Passed with exec fail',
          },
          style: TextStyle(
            fontSize: 12,
            color: switch (voteResult) {
              VoteResult.unknown => const Color(0xfff12e1f),
              VoteResult.passed => const Color(0xff35b15f),
              VoteResult.rejected => const Color(0xfff12e1f),
              VoteResult.rejectedWithVeto => const Color(0xfff12e1f),
              VoteResult.pending => const Color(0xff6c86ad),
              VoteResult.quorumNotReached => const Color(0xfff12e1f),
              VoteResult.enactment => const Color(0xff89ffb0),
              VoteResult.passedWithExecFail => const Color(0xfff12e1f),
            },
          ),
        ),
      ),
    );
  }
}
