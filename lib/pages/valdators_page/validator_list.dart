import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_list_cubit.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/user_tile.dart';

class ValidatorList extends StatelessWidget {
  final ValidatorsListCubit cubit;

  const ValidatorList({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Validator>(
      cubit: cubit,
      backgroundColor: CustomColors.background,
      onItemTap: (Validator item) => AutoRouter.of(context)
          .navigate(PortfolioRoute(address: item.address)),
      mobileBuilder: (BuildContext context, Validator? item, bool loading) {
        if (item == null || loading) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedShimmer(width: 60, height: 24),
              SizedBox(height: 16),
              SizedShimmer(width: double.infinity, height: 16),
              SizedBox(height: 8),
              SizedShimmer(width: double.infinity, height: 16),
              SizedBox(height: 8),
              SizedShimmer(width: double.infinity, height: 16),
              SizedBox(height: 8),
              SizedShimmer(width: 60, height: 16),
            ],
          );
        }

        return _MobileListTile(item: item);
      },
      columns: [
        ColumnConfig(
          title: '#',
          width: 50,
          cellBuilder: (BuildContext context, Validator item) {
            return Text(
              item.top.toString(),
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
            );
          },
        ),
        ColumnConfig(
          title: 'Validator',
          width: 300,
          cellBuilder: (BuildContext context, Validator item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IdentityAvatar(
                    size: 62, address: item.address, avatarUrl: item.logo),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.moniker),
                      const SizedBox(height: 4),
                      OpenableAddressText(address: item.proposer),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        ColumnConfig(
          title: 'Uptime',
          cellBuilder: (BuildContext context, Validator item) {
            return Text(
              '${item.uptime}%',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
        ColumnConfig(
          title: 'Streak',
          cellBuilder: (BuildContext context, Validator item) {
            return Text(
              item.streak,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
        ColumnConfig(
          title: 'Status',
          cellBuilder: (BuildContext context, Validator item) {
            return Wrap(
              spacing: 5,
              children: [
                _ValidatorStatusChip(item.status),
                _PoolStatusChip(item.stakingPoolStatus),
              ],
            );
          },
        ),
        ColumnConfig(
          title: 'Actions',
          textAlign: TextAlign.right,
          cellBuilder: (BuildContext context, Validator item) {
            return Align(
              alignment: Alignment.centerRight,
              child: SimpleTextButton(
                text: 'Delegate',
                onTap: () => DialogRouter().navigate(
                    DelegateTokensDialog(valoperAddress: item.valkey)),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MobileListTile extends StatelessWidget {
  final Validator item;

  const _MobileListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserTile(address: item.address, name: item.moniker, avatar: item.logo),
        const SizedBox(height: 24),
        MobileRow(
          title: Text(
            'Uptime',
            style:
                textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
          ),
          value: Text(
            '${item.uptime}%',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
          ),
        ),
        const SizedBox(height: 8),
        MobileRow(
          title: const Text('Streak'),
          value: Text(
            item.streak,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
          ),
        ),
        const SizedBox(height: 8),
        MobileRow(
          title: Text(
            'Status',
            style:
                textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
          ),
          value: Wrap(
            spacing: 5,
            children: [
              _ValidatorStatusChip(item.status),
              _PoolStatusChip(item.stakingPoolStatus),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            SimpleTextButton(
              text: 'Delegate',
              onTap: () => DialogRouter()
                  .navigate(DelegateTokensDialog(valoperAddress: item.valkey)),
            ),
          ],
        ),
      ],
    );
  }
}

class _ValidatorStatusChip extends StatelessWidget {
  final ValidatorStatus status;

  const _ValidatorStatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: switch (status) {
          ValidatorStatus.active => CustomColors.green,
          ValidatorStatus.inactive => CustomColors.yellow,
          ValidatorStatus.jailed => CustomColors.red,
          ValidatorStatus.paused => CustomColors.yellow,
        }
            .withOpacity(0.3),
      ),
      child: Text(
        switch (status) {
          ValidatorStatus.active => 'Active validator',
          ValidatorStatus.inactive => 'Inactive validator',
          ValidatorStatus.jailed => 'Jailed validator',
          ValidatorStatus.paused => 'Paused validator',
        },
        style: textTheme.labelMedium!.copyWith(
          color: switch (status) {
            ValidatorStatus.active => CustomColors.green,
            ValidatorStatus.inactive => CustomColors.yellow,
            ValidatorStatus.jailed => CustomColors.red,
            ValidatorStatus.paused => CustomColors.yellow,
          },
        ),
      ),
    );
  }
}

class _PoolStatusChip extends StatelessWidget {
  final StakingPoolStatus status;

  const _PoolStatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: switch (status) {
          StakingPoolStatus.withdraw => CustomColors.yellow,
          StakingPoolStatus.disabled => CustomColors.red,
          StakingPoolStatus.enabled => CustomColors.green,
        }
            .withOpacity(0.3),
      ),
      child: Text(
        switch (status) {
          StakingPoolStatus.withdraw => 'WITHDRAW',
          StakingPoolStatus.disabled => 'Staking disabled',
          StakingPoolStatus.enabled => 'Staking enabled',
        },
        style: textTheme.labelMedium!.copyWith(
          color: switch (status) {
            StakingPoolStatus.withdraw => CustomColors.yellow,
            StakingPoolStatus.disabled => CustomColors.red,
            StakingPoolStatus.enabled => CustomColors.green,
          },
        ),
      ),
    );
  }
}
