import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_list_cubit.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_chip.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/token_tile.dart';

class TransactionsList extends StatelessWidget {
  final TransactionsListCubit cubit;

  const TransactionsList({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Transaction>(
      cubit: cubit,
      mobileBuilder: (BuildContext context, Transaction? item, bool loading) {
        if (item == null || loading) {
          return const SizedShimmer(width: double.infinity, height: 200);
        }
        return _MobileListTile(item: item);
      },
      columns: <ColumnConfig<Transaction>>[
        ColumnConfig(
          title: 'Hash',
          cellBuilder: (BuildContext context, Transaction item) {
            return OpenableHash(
              hash: item.hash,
              onTap: () => AutoRouter.of(context).push(TransactionDetailsRoute(hash: item.hash)),
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
            );
          },
        ),
        ColumnConfig(
          title: 'Method',
          width: 110,
          cellBuilder: (BuildContext context, Transaction item) {
            return _MethodChip(item.method);
          },
        ),
        ColumnConfig(
          title: 'Date',
          width: 160,
          cellBuilder: (BuildContext context, Transaction item) {
            return Text(
              DateFormat('d MMM y, HH:mm').format(item.time),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'From',
          width: 160,
          cellBuilder: (BuildContext context, Transaction item) {
            return OpenableAddressText(
              address: item.from,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
            );
          },
        ),
        ColumnConfig(
          title: ' ',
          width: 70,
          cellBuilder: (BuildContext context, Transaction item) {
            return _DirectionChip(item.direction);
          },
        ),
        ColumnConfig(
          title: 'To',
          width: 160,
          cellBuilder: (BuildContext context, Transaction item) {
            return OpenableAddressText(
              address: item.to,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
            );
          },
        ),
        ColumnConfig(
          title: 'Value',
          flex: 2,
          textAlign: TextAlign.right,
          cellBuilder: (BuildContext context, Transaction item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (item.amounts.isNotEmpty)
                  Expanded(
                    child: TokenTile(
                      coin: item.amounts.firstOrNull,
                      reversed: true,
                      showAmount: true,
                    ),
                  ),
                if (item.amounts.length > 1)
                  Text(
                    ' + ${item.amounts.length - 1}',
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _MobileListTile extends StatelessWidget {
  final Transaction item;

  const _MobileListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MethodChip(item.method),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d MMM y, HH:mm').format(item.time),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (item.amounts.isNotEmpty)
                    Expanded(
                      child: TokenTile(
                        coin: item.amounts.firstOrNull,
                        reversed: true,
                        showAmount: true,
                      ),
                    ),
                  if (item.amounts.length > 1)
                    Text(
                      ' + ${item.amounts.length - 1}',
                      style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Hash',
          style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
        ),
        OpenableHash(
          hash: item.hash,
          style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
          onTap: () => AutoRouter.of(context).push(ProposalDetailsRoute(proposalId: item.hash)),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From',
                    style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                  ),
                  OpenableAddressText(
                    address: item.from,
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: _DirectionChip(item.direction, alignment: Alignment.center),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'To',
                    style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
                  ),
                  OpenableAddressText(
                    address: item.to,
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DirectionChip extends StatelessWidget {
  final String direction;
  final Alignment alignment;

  const _DirectionChip(
    this.direction, {
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomChip(
      child: Text(
        direction == 'outbound' ? 'OUT' : 'IN',
        style: textTheme.labelMedium!.copyWith(
          color: switch (direction) {
            'inbound' => const Color(0xff35b15f),
            'outbound' => const Color(0xffffa500),
            (_) => const Color(0x2935b15f),
          },
        ),
      ),
    );
  }
}

class _MethodChip extends StatelessWidget {
  final String label;

  const _MethodChip(this.label);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomChip(
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
      ),
    );
  }
}
