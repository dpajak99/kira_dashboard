import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_list_cubit.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class ProposalsList extends StatelessWidget {
  final ProposalsListCubit cubit;

  const ProposalsList({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Proposal>(
      cubit: cubit,
      backgroundColor: CustomColors.background,
      onItemTap: (Proposal e) => AutoRouter.of(context).navigate(ProposalDetailsRoute(proposalId: e.id)),
      mobileBuilder: (BuildContext context, Proposal? item, bool loading) {
        if (item == null || loading) {
          return const SizedShimmer(width: double.infinity, height: 200);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OpenableText(
              text: 'Proposal #${item.id}',
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
              onTap: () => AutoRouter.of(context).push(ProposalDetailsRoute(proposalId: item.id)),
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
            ),
            const SizedBox(height: 16),
            MobileRow(
              title: Text(
                'Status',
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
              ),
              value: _StatusChip(voteResult: item.status),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'Voters',
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
              ),
              value: Text(
                item.voters.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
              ),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'Age',
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
              ),
              value: Text(
                item.timePassed.inDays < 1 ? 'Today' : '${item.timePassed.inDays} days ago',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
              ),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'End time',
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
              ),
              value: Text(
                DateFormat('d MMM y, HH:mm').format(item.votingEndTime),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
              ),
            ),
          ],
        );
      },
      columns: [
        ColumnConfig(
          title: '#',
          width: 50,
          cellBuilder: (BuildContext context, Proposal item) {
            return Text(
              item.id,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
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
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
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
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
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
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
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
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
            );
          },
        ),
      ],
    );
  }
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
            VoteResult.pending => CustomColors.yellow,
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
          style: textTheme.labelMedium!.copyWith(
            color: switch (voteResult) {
              VoteResult.unknown => CustomColors.red,
              VoteResult.passed => CustomColors.green,
              VoteResult.rejected => CustomColors.red,
              VoteResult.rejectedWithVeto => CustomColors.red,
              VoteResult.pending => CustomColors.yellow,
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
