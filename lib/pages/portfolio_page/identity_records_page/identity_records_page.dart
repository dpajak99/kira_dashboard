import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/sliver_custom_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
  late final IdentityRecordsListCubit cubit = IdentityRecordsListCubit(address: widget.address);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverCustomCard(
          title: 'Identity records',
          enableMobile: true,
          leading: Row(
            children: [
              if (widget.isMyWallet)
                SimpleTextButton(
                  text: 'Add',
                  icon: AppIcons.add,
                  gap: 4,
                  onTap: () => DialogRouter().navigate(const RegisterIdentityRecordsDialog()),
                ),
            ],
          ),
          sliver: IdentityRecordsList(
            isMyWallet: widget.isMyWallet,
            cubit: cubit,
          ),
        ),
      ],
    );
  }
}
