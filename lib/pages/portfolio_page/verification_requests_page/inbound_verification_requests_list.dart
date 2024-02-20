import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/verification_request.dart';
import 'package:kira_dashboard/pages/portfolio_page/verification_requests_page/inbound_verification_requests_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/custom_table_paginated.dart';
import 'package:kira_dashboard/widgets/mobile_row.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/user_tile.dart';

class InboundVerificationRequestsList extends StatelessWidget {
  final bool isMyWallet;
  final InboundVerificationRequestsListCubit cubit;

  const InboundVerificationRequestsList({
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
        return _MobileListTile(
          item: item,
          isMyWallet: isMyWallet,
          onApprove: () => _handleApprove(item),
          onReject: () => _handleReject(item),
        );
      },
      columns: <ColumnConfig<VerificationRequest>>[
        ColumnConfig(
          title: 'Requested from',
          width: 200,
          cellBuilder: (BuildContext context, VerificationRequest item) {
            return UserTile(address: item.address);
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
                    text: 'Approve',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => _handleApprove(item),
                  ),
                  const SizedBox(width: 16),
                  IconTextButton(
                    text: 'Reject',
                    highlightColor: const Color(0xfffbfbfb),
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                    onTap: () => _handleReject(item),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  void _handleApprove(VerificationRequest item) {
    cubit.approveVerificationRequest(int.parse(item.id));
  }

  void _handleReject(VerificationRequest item) {
    cubit.rejectVerificationRequest(int.parse(item.id));
  }
}

class _MobileListTile extends StatelessWidget {
  final VerificationRequest item;
  final bool isMyWallet;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _MobileListTile({
    required this.item,
    required this.isMyWallet,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserTile(address: item.address),
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
        if (isMyWallet) ...<Widget>[
          const SizedBox(height: 32),
          Row(
            children: [
              IconTextButton(
                text: 'Approve',
                highlightColor: const Color(0xfffbfbfb),
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                onTap: onApprove,
              ),
              const SizedBox(width: 8),
              IconTextButton(
                text: 'Reject',
                highlightColor: const Color(0xfffbfbfb),
                style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                onTap: onReject,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
