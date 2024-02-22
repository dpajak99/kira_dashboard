import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:json_view/json_view.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ProposalDetailsPageCubit, ProposalDetailsPageState>(
      bloc: proposalDetailsPageCubit,
      builder: (BuildContext context, ProposalDetailsPageState state) {
        if (state.isLoading) {
          return Center(
            child: SizedBox(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                color: appColors.primary,
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
                          style: textTheme.titleLarge!.copyWith(color: appColors.secondary),
                        ),
                        Text(
                          state.proposalDetails!.proposal.title,
                          style: textTheme.headlineLarge!.copyWith(color: appColors.onBackground),
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
                              style: textTheme.labelLarge!.copyWith(
                                color: switch (state.proposalDetails!.proposal.simpleStatus) {
                                  VotingStatus.pending => appColors.secondary,
                                  VotingStatus.success => CustomColors.green,
                                  VotingStatus.failure => CustomColors.red,
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
                                title: Text(
                                  'For',
                                  style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
                                ),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                subtitle: Text(
                                  '${state.proposalDetails!.yesVotes.length} / ${state.proposalDetails!.totalVoters} (${state.proposalDetails!.yesVotesPercentage * 100}%)',
                                  style: textTheme.labelLarge!,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Against',
                                  style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
                                ),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                subtitle: Text(
                                  '${state.proposalDetails!.noVotes.length} / ${state.proposalDetails!.totalVoters} (${state.proposalDetails!.noVotesPercentage * 100}%)',
                                  style: textTheme.labelLarge!,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        LinearProportions(
                          proportions: [
                            ProportionValue(
                              value: state.proposalDetails?.yesVotesPercentage ?? 0,
                              color: CustomColors.green,
                            ),
                            ProportionValue(
                              value: state.proposalDetails?.noVotesPercentage ?? 0,
                              color: CustomColors.red,
                            ),
                            ProportionValue(
                              value: state.proposalDetails?.unknownVotePercentage ?? 0,
                              color: appColors.secondary,
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
            SliverToBoxAdapter(
              child: Text(
                'Description',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineMedium!.copyWith(color: appColors.onBackground),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 20)),
            SliverToBoxAdapter(
              child: CustomCard(
                child: MarkdownWidget(
                  data: state.proposalDetails!.proposal.description,
                  shrinkWrap: true,
                  config: MarkdownConfig(
                    configs: [
                      HrConfig(
                        color: appColors.outline,
                        height: 1,
                      ),
                      CustomH1Config(
                        style: textTheme.headlineMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      CustomH2Config(
                        style: textTheme.titleMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      H3Config(
                        style: textTheme.titleMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      H4Config(
                        style: textTheme.titleMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      H5Config(
                        style: textTheme.titleMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      H6Config(
                        style: textTheme.titleMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      PreConfig.darkConfig,
                      PConfig(
                        textStyle: textTheme.bodyMedium!.copyWith(
                          color: appColors.onBackground,
                        ),
                      ),
                      CodeConfig.darkConfig,
                      BlockquoteConfig.darkConfig,
                    ],
                  ),
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 32)),
            SliverToBoxAdapter(
              child: Text(
                'Details',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineMedium!.copyWith(color: appColors.onBackground),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(top: 20)),
            SliverToBoxAdapter(
              child: CustomCard(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: appColors.surface,
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

class CustomH1Config extends H1Config {
  CustomH1Config({required super.style});

  @override
  HeadingDivider? get divider => HeadingDivider(
        space: 3.6,
        color: Colors.transparent,
        height: 1,
      );
}

class CustomH2Config extends H2Config {
  CustomH2Config({required super.style});

  @override
  HeadingDivider? get divider => HeadingDivider(
        space: 2.4,
        color: Colors.transparent,
        height: 1,
      );
}

class _StatusChip extends StatelessWidget {
  final VoteResult voteResult;

  const _StatusChip({required this.voteResult});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (voteResult) {
            VoteResult.unknown => CustomColors.red,
            VoteResult.passed => CustomColors.green,
            VoteResult.rejected => CustomColors.red,
            VoteResult.rejectedWithVeto => CustomColors.red,
            VoteResult.pending => appColors.secondary,
            VoteResult.quorumNotReached => CustomColors.red,
            VoteResult.enactment => CustomColors.green,
            VoteResult.passedWithExecFail => CustomColors.red,
          }.withOpacity(0.3),
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
          style: textTheme.labelLarge!.copyWith(
            color: switch (voteResult) {
              VoteResult.unknown => CustomColors.red,
              VoteResult.passed => CustomColors.green,
              VoteResult.rejected => CustomColors.red,
              VoteResult.rejectedWithVeto => CustomColors.red,
              VoteResult.pending => appColors.secondary,
              VoteResult.quorumNotReached => CustomColors.red,
              VoteResult.enactment => CustomColors.green,
              VoteResult.passedWithExecFail => CustomColors.red,
            },
          ),
        ),
      ),
    );
  }
}
