import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegations_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/validator_tile.dart';

class UndelegationList extends StatelessWidget {
  final bool isMyWallet;
  final UndelegationsListCubit undelegationsListCubit;

  const UndelegationList({
    super.key,
    required this.isMyWallet,
    required this.undelegationsListCubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<Undelegation>(
      cubit: undelegationsListCubit,
      mobileBuilder: (BuildContext context, Undelegation? item, bool loading) {
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
          onClaim: () => _handleClaimUndelegation(item),
        );
      },
      columns: <ColumnConfig<Undelegation>>[
        ColumnConfig(
          title: 'Validator',
          flex: 2,
          cellBuilder: (BuildContext context, Undelegation item) {
            return ValidatorTile(
              moniker: item.validatorInfo.moniker,
              address: item.validatorInfo.address,
            );
          },
        ),
        ColumnConfig(
          title: 'Amount',
          flex: 2,
          cellBuilder: (BuildContext context, Undelegation item) {
            return Text(
              item.amounts.map((e) => e.toNetworkDenominationString()).join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
            );
          },
        ),
        ColumnConfig(
          title: 'Claim',
          textAlign: TextAlign.right,
          cellBuilder: (BuildContext context, Undelegation item) {
            if (item.isClaimable && isMyWallet) {
              return Align(
                alignment: Alignment.centerRight,
                child: SimpleTextButton(
                  text: 'Claim',
                  onTap: () => _handleClaimUndelegation(item),
                ),
              );
            }

            return Text(
              DateFormat('d MMM y, HH:mm').format(item.expiry),
              style: textTheme.bodyMedium!.copyWith(color: item.isClaimable ? CustomColors.green : CustomColors.red),
              textAlign: TextAlign.right,
            );
          },
        ),
      ],
    );
  }

  void _handleClaimUndelegation(Undelegation item) {
    undelegationsListCubit.claimUndelegation(undelegationId: item.id.toString());
  }
}

class _MobileListTile extends StatelessWidget {
  final Undelegation item;
  final bool isMyWallet;
  final VoidCallback? onClaim;

  const _MobileListTile({
    required this.item,
    required this.isMyWallet,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidatorTile(
          moniker: item.validatorInfo.moniker,
          address: item.validatorInfo.address,
        ),
        const SizedBox(height: 24),
        MobileRow(
          title: Text(
            'Amounts',
            style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
          ),
          value: Text(
            item.amounts.map((e) => e.toNetworkDenominationString()).join(', '),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
          ),
        ),
        if (item.isClaimable == false) ...<Widget>[
          const SizedBox(height: 8),
          MobileRow(
            title: Text(
              'Claim after',
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
            ),
            value: Text(
              DateFormat('d MMM y, HH:mm').format(item.expiry),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
            ),
          ),
        ],
        if (isMyWallet && item.isClaimable) ...<Widget>[
          const SizedBox(height: 32),
          SimpleTextButton(
            text: 'Claim',
            onTap: onClaim,
          ),
        ],
      ],
    );
  }
}
