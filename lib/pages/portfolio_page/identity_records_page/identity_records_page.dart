import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';

class IdentityRecordsPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const IdentityRecordsPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _IdentityRecordsPageState();
}

class _IdentityRecordsPageState extends State<IdentityRecordsPage> {
  late final IdentityRecordsListCubit cubit = IdentityRecordsListCubit(
    address: widget.address,
    isMyWallet: widget.isMyWallet,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdentityRecordsListCubit, IdentityRecordsListState>(
      bloc: cubit,
      builder: (BuildContext context, IdentityRecordsListState state) {
        return Column(
          children: [
            CustomCard(
              title: 'Identity records',
              leading: Row(
                children: [
                  if (widget.isMyWallet)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: IconTextButton(
                        text: 'Add',
                        icon: AppIcons.add,
                        gap: 4,
                        highlightColor: const Color(0xfffbfbfb),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff4888f0),
                        ),
                        onTap: () => DialogRouter().navigate(const RegisterIdentityRecordsDialog()),
                      ),
                    ),
                ],
              ),
              child: CustomTable(
                items: state.records,
                pageSize: state.pageSize,
                loading: state.isLoading,
                mobileBuilder: (BuildContext context, IdentityRecord? item, bool loading) {
                  return const Text('dupa');
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
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
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
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Status',
                    cellBuilder: (BuildContext context, IdentityRecord item) {
                      return _VerificationChip(verified: item.verifiers.isNotEmpty);
                    },
                  ),
                  if (widget.isMyWallet)
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
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff4888f0),
                              ),
                              onTap: () => DialogRouter().navigate(RegisterIdentityRecordsDialog(records: [item])),
                            ),
                            const SizedBox(width: 16),
                            IconTextButton(
                              text: 'Verify',
                              highlightColor: const Color(0xfffbfbfb),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff4888f0),
                              ),
                              onTap: () => DialogRouter().navigate(VerifyIdentityRecordsDialog(
                                records: [item],
                              )),
                            ),
                            const SizedBox(width: 16),
                            IconTextButton(
                              text: 'Delete',
                              highlightColor: const Color(0xfffbfbfb),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xff4888f0),
                              ),
                              onTap: () => DialogRouter().navigate(DeleteIdentityRecordsDialog(records: [item])),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VerificationChip extends StatelessWidget {
  final bool verified;

  const _VerificationChip({required this.verified});

  @override
  Widget build(BuildContext context) {
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
          style: TextStyle(
            fontSize: 12,
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
