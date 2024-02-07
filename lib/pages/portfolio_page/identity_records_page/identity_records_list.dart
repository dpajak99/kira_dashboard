import 'package:flutter/material.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class IdentityRecordsList extends StatelessWidget {
  final bool isMyWallet;
  final IdentityRecordsListCubit cubit;

  const IdentityRecordsList({
    super.key,
    required this.isMyWallet,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated(
      cubit: cubit,
      mobileBuilder: (BuildContext context, IdentityRecord? item, bool loading) {
        if (item == null || loading) {
          return const SizedShimmer(width: double.infinity, height: 200);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key',
                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                      ),
                      Text(
                        item.key,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                      ),
                    ],
                  ),
                ),
                _VerificationChip(verified: item.verifiers.isNotEmpty),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Value',
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
            ),
            Text(
              item.value,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            ),
            if (isMyWallet) ...<Widget>[
              const SizedBox(height: 16),
              Row(
                children: [
                  IconTextButton(
                    text: 'Edit',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(RegisterIdentityRecordsDialog(records: [item])),
                  ),
                  const SizedBox(width: 16),
                  IconTextButton(
                    text: 'Verify',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(VerifyIdentityRecordsDialog(
                      records: [item],
                    )),
                  ),
                  const SizedBox(width: 16),
                  IconTextButton(
                    text: 'Delete',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(DeleteIdentityRecordsDialog(records: [item])),
                  ),
                ],
              ),
            ],
          ],
        );
      },
      columns: [
        ColumnConfig(
          title: 'Key',
          flex: 1,
          cellBuilder: (BuildContext context, IdentityRecord item) {
            return Text(
              item.key,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Value',
          flex: 2,
          cellBuilder: (BuildContext context, IdentityRecord item) {
            return Text(
              item.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Status',
          cellBuilder: (BuildContext context, IdentityRecord item) {
            return _VerificationChip(verified: item.verifiers.isNotEmpty);
          },
        ),
        if (isMyWallet)
          ColumnConfig(
            title: 'Actions',
            textAlign: TextAlign.right,
            cellBuilder: (BuildContext context, IdentityRecord item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconTextButton(
                    text: 'Edit',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(RegisterIdentityRecordsDialog(records: [item])),
                  ),
                  const SizedBox(width: 16),
                  IconTextButton(
                    text: 'Verify',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(VerifyIdentityRecordsDialog(
                      records: [item],
                    )),
                  ),
                  const SizedBox(width: 16),
                  IconTextButton(
                    text: 'Delete',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => DialogRouter().navigate(DeleteIdentityRecordsDialog(records: [item])),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}


class _VerificationChip extends StatelessWidget {
  final bool verified;

  const _VerificationChip({required this.verified});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (verified) {
            true => const Color(0x2935b15f),
            false => const Color(0x29f12e1f),
          },
        ),
        child: Text(
          verified ? 'Verified' : 'Unverified',
          style: textTheme.labelMedium!.copyWith(
            color: switch (verified) {
              true => const Color(0xff35b15f),
              false => const Color(0xfff12e1f),
            },
          ),
        ),
      ),
    );
  }
}
