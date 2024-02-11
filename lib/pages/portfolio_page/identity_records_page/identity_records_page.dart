import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        CustomCard(
          title: 'Identity records',
          enableMobile: true,
          leading: Row(
            children: [
              if (widget.isMyWallet)
                IconTextButton(
                  text: 'Add',
                  icon: AppIcons.add,
                  gap: 4,
                  highlightColor: const Color(0xfffbfbfb),
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                  onTap: () => DialogRouter().navigate(const RegisterIdentityRecordsDialog()),
                ),
            ],
          ),
          child: IdentityRecordsList(
            isMyWallet: widget.isMyWallet,
            cubit: cubit,
          ),
        ),
      ],
    );
  }
}
