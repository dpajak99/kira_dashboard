import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/balances_page/balances_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';

class BalancesPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const BalancesPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  late final BalancesListCubit cubit = BalancesListCubit(
    address: widget.address,
    isMyWallet: widget.isMyWallet,
  );

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Tokens',
      enableMobile: true,
      child: BalancesList(
        isMyWallet: widget.isMyWallet,
        cubit: cubit,
      ),
    );
  }
}

