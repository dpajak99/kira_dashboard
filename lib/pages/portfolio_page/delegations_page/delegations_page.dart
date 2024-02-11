import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegation_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegations_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';

class DelegationsPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const DelegationsPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  DelegationsPageState createState() => DelegationsPageState();
}

class DelegationsPageState extends State<DelegationsPage> {
  late final DelegationsListCubit delegationsListCubit = DelegationsListCubit(address: widget.address, isMyWallet: widget.isMyWallet);
  late final UndelegationsListCubit undelegationsListCubit = UndelegationsListCubit(address: widget.address, isMyWallet: widget.isMyWallet);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        CustomCard(
          title: 'Undelegations',
          enableMobile: true,
          child: UndelegationList(
            isMyWallet: widget.isMyWallet,
            undelegationsListCubit: undelegationsListCubit,
          ),
        ),
        const SizedBox(height: 32),
        CustomCard(
          title: 'Delegations',
          enableMobile: true,
          leading: Row(
            children: [
              if (widget.isMyWallet)
                IconTextButton(
                  text: 'Claim rewards',
                  highlightColor: const Color(0xfffbfbfb),
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                  onTap: () {},
                ),
            ],
          ),
          child: DelegationList(
            isMyWallet: widget.isMyWallet,
            delegationsListCubit: delegationsListCubit,
          ),
        ),
      ],
    );
  }
}
