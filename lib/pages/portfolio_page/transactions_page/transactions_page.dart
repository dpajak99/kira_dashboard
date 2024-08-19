import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_list.dart';
import 'package:kira_dashboard/pages/portfolio_page/transactions_page/transactions_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/sliver_custom_card.dart';

class TransactionsPage extends StatefulWidget {
  final String address;
  final bool isMyWallet;

  const TransactionsPage({
    super.key,
    required this.address,
    required this.isMyWallet,
  });

  @override
  State<StatefulWidget> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late final TransactionsListCubit cubit = TransactionsListCubit(address: widget.address);

  @override
  Widget build(BuildContext context) {
    return SliverCustomCard(
      title: 'Transactions',
      enableMobile: true,
      sliver: TransactionsList(cubit: cubit),
    );
  }
}
