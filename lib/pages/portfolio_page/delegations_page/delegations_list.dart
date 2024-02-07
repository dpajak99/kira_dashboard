import 'package:flutter/material.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class DelegationList extends StatelessWidget {
  final bool isMyWallet;
  final DelegationsListCubit delegationsListCubit;

  const DelegationList({
    super.key,
    required this.isMyWallet,
    required this.delegationsListCubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Delegation>(
      cubit: delegationsListCubit,
      mobileBuilder: (BuildContext context, Delegation? item, bool loading) {
        if (item == null || loading) {
          return const SizedShimmer(width: double.infinity, height: 200);
        }

        return Column(
          children: [
            Row(
              children: <Widget>[
                IdentityAvatar(size: 32, address: item.validatorInfo.address),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.validatorInfo.moniker,
                        maxLines: 1,
                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                      ),
                      const SizedBox(height: 4),
                      OpenableAddressText(
                        address: item.validatorInfo.address,
                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                      ),
                    ],
                  ),
                ),
                if (isMyWallet) ...<Widget>[
                  IconTextButton(
                    text: 'Delegate',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(DelegateTokensDialog(valoperAddress: item.validatorInfo.valkey)),
                  ),
                  const SizedBox(width: 8),
                  IconTextButton(
                    text: 'Undelegate',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(UndelegateTokensDialog(valoperAddress: item.validatorInfo.valkey)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            MobileRow(
              title: Text(
                'Status',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: _StatusChip(stakingPoolStatus: item.poolInfo.status),
            ),
            const SizedBox(height: 8),
            MobileRow(
                title: Text(
                  'Commision',
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                ),
                value: Text(
                  '${item.poolInfo.commissionPercentage}%',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                )),
          ],
        );
      },
      columns: <ColumnConfig<Delegation>>[
        ColumnConfig(
          title: 'Validator',
          cellBuilder: (BuildContext context, Delegation item) {
            return Row(
              children: <Widget>[
                IdentityAvatar(size: 32, address: item.validatorInfo.address),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.validatorInfo.moniker,
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                  ),
                ),
              ],
            );
          },
        ),
        ColumnConfig(
          title: 'Status',
          cellBuilder: (BuildContext context, Delegation item) {
            return _StatusChip(stakingPoolStatus: item.poolInfo.status);
          },
        ),
        ColumnConfig(
          title: 'Commission',
          textAlign: TextAlign.right,
          cellBuilder: (BuildContext context, Delegation item) {
            return Text(
              '${item.poolInfo.commissionPercentage}%',
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              textAlign: TextAlign.right,
            );
          },
        ),
        if (isMyWallet)
          ColumnConfig(
            title: 'Actions',
            textAlign: TextAlign.right,
            cellBuilder: (BuildContext context, Delegation item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconTextButton(
                    text: 'Undelegate',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(UndelegateTokensDialog(valoperAddress: item.validatorInfo.valkey)),
                  ),
                  const SizedBox(width: 16),
                  IconTextButton(
                    text: 'Delegate',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(DelegateTokensDialog(valoperAddress: item.validatorInfo.valkey)),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final StakingPoolStatus stakingPoolStatus;

  const _StatusChip({required this.stakingPoolStatus});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (stakingPoolStatus) {
            StakingPoolStatus.disabled => const Color(0x29f12e1f),
            StakingPoolStatus.enabled => const Color(0x2935b15f),
            StakingPoolStatus.withdraw => const Color(0x29ffa500),
          },
        ),
        child: Text(
          switch (stakingPoolStatus) {
            StakingPoolStatus.disabled => 'Disabled',
            StakingPoolStatus.enabled => 'Enabled',
            StakingPoolStatus.withdraw => 'Withdraw only'
          },
          style: textTheme.labelMedium!.copyWith(
            color: switch (stakingPoolStatus) {
              StakingPoolStatus.disabled => const Color(0xfff12e1f),
              StakingPoolStatus.enabled => const Color(0xff35b15f),
              StakingPoolStatus.withdraw => const Color(0xffffa500),
            },
          ),
        ),
      ),
    );
  }
}