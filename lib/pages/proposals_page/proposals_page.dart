import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_page_cubit.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_page_state.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';
import 'package:kira_dashboard/widgets/sliver_page_padding.dart';

@RoutePage()
class ProposalsPage extends StatefulWidget {
  const ProposalsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  final ProposalsPageCubit proposalsPageCubit = ProposalsPageCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProposalsPageCubit, ProposalsPageState>(
      bloc: proposalsPageCubit,
      builder: (BuildContext context, ProposalsPageState state) {
        return PageScaffold(
          slivers: [
            SliverPagePadding(
              sliver: SliverToBoxAdapter(
                child: CustomCard(
                  title: 'Proposals',
                  child: CustomTable<Proposal>(
                    pageSize: state.pageSize,
                    loading: state.isLoading,
                    items: state.proposals,
                    columns: [
                      ColumnConfig(
                        title: 'ID',
                        width: 80,
                        cellBuilder: (BuildContext context, Proposal item) {
                          return Text(
                            item.id,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xfffbfbfb),
                            ),
                          );
                        },
                      ),
                      ColumnConfig(
                        title: 'Title',
                        flex: 2,
                        cellBuilder: (BuildContext context, Proposal item) {
                          return Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xfffbfbfb),
                            ),
                          );
                        },
                      ),
                      ColumnConfig(
                        title: 'Status',
                        width: 150,
                        cellBuilder: (BuildContext context, Proposal item) {
                          return _StatusChip(voteResult: item.status);
                        },
                      ),
                      ColumnConfig(
                        title: 'Voters',
                        width: 100,
                        cellBuilder: (BuildContext context, Proposal item) {
                          return Text(
                            item.voters.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xfffbfbfb),
                            ),
                          );
                        },
                      ),
                      ColumnConfig(
                        title: 'Age',
                        cellBuilder: (BuildContext context, Proposal item) {
                          return Text(
                            item.timePassed.inDays < 1 ? 'Today' : '${item.timePassed.inDays} days ago',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xfffbfbfb),
                            ),
                          );
                        },
                      ),
                      ColumnConfig(
                        title: 'End time',
                        cellBuilder: (BuildContext context, Proposal item) {
                          return Text(
                            DateFormat('d MMM y, HH:mm').format(item.votingEndTime),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xfffbfbfb),
                            ),
                          );
                        },
                      ),
                    ],
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
            VoteResult.pending => const Color(0x29ffa500),
            VoteResult.quorumNotReached => const Color(0x29f12e1f),
            VoteResult.enactment => const Color(0x29f12e1f),
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
              VoteResult.pending => const Color(0xffffa500),
              VoteResult.quorumNotReached => const Color(0xfff12e1f),
              VoteResult.enactment => const Color(0xfff12e1f),
              VoteResult.passedWithExecFail => const Color(0xfff12e1f),
            },
          ),
        ),
      ),
    );
  }
}