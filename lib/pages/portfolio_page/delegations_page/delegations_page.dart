import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/delegations_list_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegation_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/delegations_page/undelegations_list_cubit.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/sliver_custom_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
  late final DelegationsListCubit delegationsListCubit = DelegationsListCubit(
      address: widget.address, isMyWallet: widget.isMyWallet);
  late final UndelegationsListCubit undelegationsListCubit =
      UndelegationsListCubit(
          address: widget.address, isMyWallet: widget.isMyWallet);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverCustomCard(
          title: 'Undelegations',
          enableMobile: true,
          sliver: UndelegationList(
            isMyWallet: widget.isMyWallet,
            undelegationsListCubit: undelegationsListCubit,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
        SliverCustomCard(
          title: 'Delegations',
          enableMobile: true,
          leading: Row(
            children: [
              if (widget.isMyWallet)
                SimpleTextButton(
                  text: 'Claim rewards',
                  onTap: () {},
                ),
            ],
          ),
          sliver: DelegationList(
            isMyWallet: widget.isMyWallet,
            delegationsListCubit: delegationsListCubit,
          ),
        ),
      ],
    );
  }
}
