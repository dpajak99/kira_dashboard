import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_chip.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';
import 'package:kira_dashboard/widgets/labeled_text.dart';
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

    return BlocBuilder(
      bloc: cubit,
      builder: (BuildContext context, IdentityRecordsListState state) {
        return CustomTable(
          items: state.records,
          loading: state.isLoading,
          mobileBuilder: (BuildContext context, IdentityRecord? item, bool loading) {
            if (item == null || loading) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedShimmer(width: 60, height: 24),
                  SizedBox(height: 16),
                  SizedShimmer(width: double.infinity, height: 24),
                  SizedBox(height: 8),
                  SizedShimmer(width: 60, height: 16),
                ],
              );
            }
            return _MobileListTile(
              item: item,
              isMyWallet: isMyWallet,
              onEdit: () => _handleEdit(item),
              onVerify: () => _handleVerify(item),
              onDelete: () => _handleDelete(item),
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
                  style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
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
                  style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
                );
              },
            ),
            ColumnConfig(
              title: 'Status',
              cellBuilder: (BuildContext context, IdentityRecord item) {
                return _VerificationChip(
                  verifiers: item.verifiers,
                  trustedVerifiers: item.trustedVerifiers,
                );
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
                      SimpleTextButton(
                        text: 'Edit',
                        onTap: () => _handleEdit(item),
                      ),
                      const SizedBox(width: 16),
                      SimpleTextButton(
                        text: 'Verify',
                        onTap: () => _handleVerify(item),
                      ),
                      const SizedBox(width: 16),
                      SimpleTextButton(
                        text: 'Delete',
                        onTap: () => _handleDelete(item),
                      ),
                    ],
                  );
                },
              ),
          ],
        );
      },
    );
  }

  void _handleEdit(IdentityRecord item) {
    DialogRouter().navigate(RegisterIdentityRecordsDialog(records: [item]));
  }

  void _handleVerify(IdentityRecord item) {
    DialogRouter().navigate(VerifyIdentityRecordsDialog(records: [item]));
  }

  void _handleDelete(IdentityRecord item) {
    DialogRouter().navigate(DeleteIdentityRecordsDialog(records: [item]));
  }
}

class _MobileListTile extends StatelessWidget {
  final IdentityRecord item;
  final bool isMyWallet;
  final VoidCallback onEdit;
  final VoidCallback onVerify;
  final VoidCallback onDelete;

  const _MobileListTile({
    required this.item,
    required this.isMyWallet,
    required this.onEdit,
    required this.onVerify,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: LabeledText(
                label: 'Key',
                text: item.key,
              ),
            ),
            _VerificationChip(
              verifiers: item.verifiers,
              trustedVerifiers: item.trustedVerifiers,
            ),
          ],
        ),
        const SizedBox(height: 16),
        LabeledText(
          label: 'Value',
          text: item.value,
        ),
        if (isMyWallet) ...<Widget>[
          const SizedBox(height: 16),
          Row(
            children: [
              SimpleTextButton(
                text: 'Edit',
                onTap: () => DialogRouter().navigate(RegisterIdentityRecordsDialog(records: [item])),
              ),
              const SizedBox(width: 16),
              SimpleTextButton(
                text: 'Verify',
                onTap: () => DialogRouter().navigate(VerifyIdentityRecordsDialog(
                  records: [item],
                )),
              ),
              const SizedBox(width: 16),
              SimpleTextButton(
                text: 'Delete',
                onTap: () => DialogRouter().navigate(DeleteIdentityRecordsDialog(records: [item])),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _VerificationChip extends StatelessWidget {
  final List<String> verifiers;
  final List<String> trustedVerifiers;

  const _VerificationChip({
    required this.verifiers,
    required this.trustedVerifiers,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Color textColor;
    String label;

    if (trustedVerifiers.isNotEmpty) {
      textColor = CustomColors.green;
      label = 'Trusted by ${trustedVerifiers.length}';
    } else if (verifiers.isNotEmpty) {
      textColor = CustomColors.green;
      label = 'Verified by ${verifiers.length}';
    } else {
      textColor = CustomColors.red;
      label = 'Unverified';
    }

    Widget child = CustomChip(
      child: Text(
        label,
        style: textTheme.labelMedium!.copyWith(color: textColor),
      ),
    );

    if (trustedVerifiers.isNotEmpty) {
      return Tooltip(
        message: 'Verified by your trusted addresses:\n- ${trustedVerifiers.join('\n- ')}',
        child: child,
      );
    } else if (verifiers.isNotEmpty) {
      return Tooltip(
        message: 'Verified by:\n- ${verifiers.join('\n- ')}',
        child: child,
      );
    } else {
      return child;
    }
  }
}
