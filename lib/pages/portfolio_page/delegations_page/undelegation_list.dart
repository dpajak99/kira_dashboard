import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegations_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

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
                      Text(item.validatorInfo.moniker, style: textTheme.bodyMedium?.copyWith(color: const Color(0xfffbfbfb))),
                      const SizedBox(height: 4),
                      OpenableAddressText(
                        address: item.validatorInfo.address,
                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                      ),
                    ],
                  ),
                ),
                if (isMyWallet && item.isClaimable)
                  IconTextButton(
                    text: 'Claim',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => undelegationsListCubit.claimUndelegation(undelegationId: item.id.toString()),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            MobileRow(
              title: Text(
                'Amounts',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: Text(
                item.amounts.map((e) => e.toNetworkDenominationString()).join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              ),
            ),
            if (item.isClaimable == false) ...<Widget>[
              const SizedBox(height: 8),
              MobileRow(
                title: Text(
                  'Claim after',
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                ),
                value: Text(
                  DateFormat('d MMM y, HH:mm').format(item.expiry),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                ),
              ),
            ]
          ],
        );
      },
      columns: <ColumnConfig<Undelegation>>[
        ColumnConfig(
          title: 'Validator',
          cellBuilder: (BuildContext context, Undelegation item) {
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
          title: 'Amount',
          cellBuilder: (BuildContext context, Undelegation item) {
            return Text(
              item.amounts.map((e) => e.toNetworkDenominationString()).join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
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
                child: IconTextButton(
                  text: 'Claim',
                  highlightColor: const Color(0xfffbfbfb),
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                  onTap: () => undelegationsListCubit.claimUndelegation(undelegationId: item.id.toString()),
                ),
              );
            }

            return Text(
              DateFormat('d MMM y, HH:mm').format(item.expiry),
              style: textTheme.bodyMedium!.copyWith(color: item.isClaimable ? const Color(0xff35b15f) : const Color(0xfff12e1f)),
              textAlign: TextAlign.right,
            );
          },
        ),
      ],
    );
  }
}
