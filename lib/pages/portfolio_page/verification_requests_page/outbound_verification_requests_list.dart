import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/outbound_verification_requests_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class OutboundVerificationRequestsList extends StatelessWidget {
  final bool isMyWallet;
  final OutboundVerificationRequestsListCubit cubit;

  const OutboundVerificationRequestsList({
    super.key,
    required this.isMyWallet,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomTablePaginated<VerificationRequest>(
      cubit: cubit,
      mobileBuilder: (BuildContext context, VerificationRequest? item, bool loading) {
        if (item == null || loading) {
          return const SizedShimmer(width: double.infinity, height: 200);
        }
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IdentityAvatar(size: 32, address: item.address),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OpenableAddressText(
                          address: item.address,
                          style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isMyWallet)
                  IconTextButton(
                    text: 'Cancel',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => cubit.cancelVerificationRequest(int.parse(item.id)),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            MobileRow(
              title: Text(
                'Records',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: Text(
                item.records.map((e) => e.key).join(', '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              ),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'Edited',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: Text(
                DateFormat('d MMM y, HH:mm').format(item.lastRecordEditDate),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              ),
            ),
            const SizedBox(height: 8),
            MobileRow(
              title: Text(
                'Tip',
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
              ),
              value: Text(
                item.tip.toNetworkDenominationString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
              ),
            ),
          ],
        );
      },
      columns: <ColumnConfig<VerificationRequest>>[
        ColumnConfig(
          title: 'Requested to',
          width: 200,
          cellBuilder: (BuildContext context, VerificationRequest item) {
            return Row(
              children: <Widget>[
                IdentityAvatar(size: 32, address: item.verifier),
                const SizedBox(width: 12),
                Expanded(
                  child: CopyableAddressText(
                    address: item.verifier,
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff2f8af5)),
                  ),
                ),
              ],
            );
          },
        ),
        ColumnConfig(
          title: 'Edited',
          cellBuilder: (BuildContext context, VerificationRequest item) {
            return Text(
              DateFormat('d MMM y, HH:mm').format(item.lastRecordEditDate),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Records',
          cellBuilder: (BuildContext context, VerificationRequest item) {
            return Text(
              item.records.map((e) => e.key).join(', '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        ColumnConfig(
          title: 'Tip',
          textAlign: TextAlign.right,
          cellBuilder: (BuildContext context, VerificationRequest item) {
            return Text(
              item.tip.toNetworkDenominationString(),
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            );
          },
        ),
        if (isMyWallet)
          ColumnConfig(
            title: 'Actions',
            textAlign: TextAlign.right,
            cellBuilder: (BuildContext context, VerificationRequest item) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconTextButton(
                    text: 'Cancel',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => cubit.cancelVerificationRequest(int.parse(item.id)),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
