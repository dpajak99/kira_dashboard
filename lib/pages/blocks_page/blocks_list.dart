import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/pages/blocks_page/blocks_list_cubit.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class BlocksList extends StatelessWidget {
  final BlocksListCubit cubit;

  const BlocksList({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Block>(
      cubit: cubit,
      onItemTap: (Block item) => AutoRouter.of(context).push(BlockDetailsRoute(height: item.height)),
      mobileBuilder: (BuildContext context, Block? item, bool loading) {
        if (item == null || loading) {
          return const SizedShimmer(width: double.infinity, height: 200);
        }
        String hrTime = item.time.difference(DateTime.now()).inSeconds > 0
            ? '${item.time.difference(DateTime.now()).inSeconds.abs()} sec ago'
            : '${item.time.difference(DateTime.now()).inMinutes.abs()} min ago';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OpenableText(
              text: 'Block #${item.height}',
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              onTap: () => AutoRouter.of(context).push(BlockDetailsRoute(height: item.height)),
            ),
            const SizedBox(height: 4),
            CopyableHash(
              hash: '0x${item.hash}',
              style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
            ),
            const SizedBox(height: 16),
            MobileRow(
              title: Text(
                'Block time:',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: RichText(
                text: TextSpan(
                  text: '${DateFormat('d MMM y, HH:mm').format(item.time)} ($hrTime)',
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'Proposed by:',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: Row(
                children: [
                  IdentityAvatar(size: 16, address: item.proposer),
                  const SizedBox(width: 4),
                  OpenableAddressText(
                    address: item.proposer,
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'Transactions:',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: OpenableText(
                text: item.numTxs,
                onTap: () => AutoRouter.of(context).push(BlockTransactionsRoute(blockId: item.height)),
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              ),
            ),
          ],
        );
      },
      columns: [
        ColumnConfig(
          title: 'Height',
          width: 120,
          cellBuilder: (BuildContext context, Block item) {
            return Text(
              item.height,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Proposer',
          width: 240,
          cellBuilder: (BuildContext context, Block item) {
            return Row(
              children: <Widget>[
                IdentityAvatar(size: 20, address: item.proposer),
                const SizedBox(width: 8),
                Expanded(
                  child: OpenableAddressText(
                    address: item.proposer,
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                  ),
                ),
              ],
            );
          },
        ),
        ColumnConfig(
          title: 'Hash',
          cellBuilder: (BuildContext context, Block item) {
            return Text(
              '0x${item.hash}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Transactions',
          cellBuilder: (BuildContext context, Block item) {
            return OpenableText(
              text: item.numTxs,
              onTap: () => AutoRouter.of(context).push(BlockTransactionsRoute(blockId: item.height)),
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Age',
          cellBuilder: (BuildContext context, Block item) {
            Duration duration = item.time.difference(DateTime.now());
            return Text(
              switch (duration.inSeconds.abs()) {
                == 0 => 'just now',
                == 1 => '1 second ago',
                < 60 => '${duration.inSeconds.abs()} seconds ago',
                < 120 => '1 minute ago',
                < 3600 => '${duration.inMinutes.abs()} minutes ago',
                < 7200 => '1 hour ago',
                < 86400 => '${duration.inHours.abs()} hours ago',
                < 172800 => '1 day ago',
                < 604800 => '${duration.inDays.abs()} weeks ago',
                < 1209600 => '1 month ago',
                < 2592000 => '${duration.inDays.abs()} months ago',
                < 5184000 => '1 year ago',
                (_) => '${(duration.inDays.abs() / 365).ceil()} years ago',
              },
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
      ],
    );
  }
}
