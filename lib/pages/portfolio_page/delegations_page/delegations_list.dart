import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_chip.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/validator_tile.dart';

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
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedShimmer(width: 60, height: 24),
              SizedBox(height: 8),
              SizedShimmer(width: double.infinity, height: 16),
              SizedBox(height: 16),
              SizedShimmer(width: 60, height: 16),
            ],
          );
        }
        return _MobileListTile(
          item: item,
          isMyWallet: isMyWallet,
          onDelegate: () => _handleDelegate(item),
          onUndelegate: () => _handleUndelegate(item),
        );
      },
      columns: <ColumnConfig<Delegation>>[
        ColumnConfig(
          title: 'Validator',
          flex: 2,
          cellBuilder: (BuildContext context, Delegation item) {
            return ValidatorTile(
              moniker: item.validatorInfo.moniker,
              address: item.validatorInfo.address,
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
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
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
                  SimpleTextButton(
                    text: 'Undelegate',
                    onTap: () => _handleUndelegate(item),
                  ),
                  const SizedBox(width: 16),
                  SimpleTextButton(
                    text: 'Delegate',
                    onTap: () => _handleDelegate(item),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  void _handleUndelegate(Delegation item) {
    DialogRouter().navigate(UndelegateTokensDialog(valoperAddress: item.validatorInfo.valkey));
  }

  void _handleDelegate(Delegation item) {
    DialogRouter().navigate(DelegateTokensDialog(valoperAddress: item.validatorInfo.valkey));
  }
}

class _MobileListTile extends StatelessWidget {
  final Delegation item;
  final bool isMyWallet;
  final VoidCallback onDelegate;
  final VoidCallback onUndelegate;

  const _MobileListTile({
    required this.item,
    required this.isMyWallet,
    required this.onDelegate,
    required this.onUndelegate,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        ValidatorTile(
          moniker: item.validatorInfo.moniker,
          address: item.validatorInfo.address,
        ),
        const SizedBox(height: 24),
        MobileRow(
          title: Text(
            'Status',
            style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
          ),
          value: _StatusChip(stakingPoolStatus: item.poolInfo.status),
        ),
        const SizedBox(height: 8),
        MobileRow(
          title: Text(
            'Commision',
            style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
          ),
          value: Text(
            '${item.poolInfo.commissionPercentage}%',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
          ),
        ),
        if (isMyWallet) ...<Widget>[
          const SizedBox(height: 32),
          Row(
            children: [
              SimpleTextButton(
                text: 'Delegate',
                onTap: () => DialogRouter().navigate(DelegateTokensDialog(valoperAddress: item.validatorInfo.valkey)),
              ),
              const SizedBox(width: 8),
              SimpleTextButton(
                text: 'Undelegate',
                onTap: () => DialogRouter().navigate(UndelegateTokensDialog(valoperAddress: item.validatorInfo.valkey)),
              ),
            ],
          ),
        ],
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

    return CustomChip(
      child: Text(
        switch (stakingPoolStatus) {
          StakingPoolStatus.disabled => 'Disabled',
          StakingPoolStatus.enabled => 'Enabled',
          StakingPoolStatus.withdraw => 'Withdraw only'
        },
        style: textTheme.labelMedium!.copyWith(
          color: switch (stakingPoolStatus) {
            StakingPoolStatus.disabled => CustomColors.red,
            StakingPoolStatus.enabled => CustomColors.green,
            StakingPoolStatus.withdraw => CustomColors.yellow,
          },
        ),
      ),
    );
  }
}
