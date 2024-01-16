import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/models/transaction.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';

class TransactionsPage extends StatelessWidget {
  final PortfolioPageState state;

  const TransactionsPage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Transactions',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTable<Transaction>(
            items: state.transactions,
            columns: <ColumnConfig<Transaction>>[
              ColumnConfig(
                title: 'Hash',
                cellBuilder: (BuildContext context, Transaction item) {
                  return Text(
                    item.hash,
                    style: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
