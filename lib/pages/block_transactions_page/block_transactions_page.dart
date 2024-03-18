import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_list.dart';
import 'package:kira_dashboard/pages/block_transactions_page/block_transactions_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';

@RoutePage()
class BlockTransactionsPage extends StatefulWidget {
  final String? blockId;

  const BlockTransactionsPage({
    @QueryParam('block') this.blockId,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _BlockTransactionsPageState();
}

class _BlockTransactionsPageState extends State<BlockTransactionsPage> {
  late final BlockTransactionsListCubit cubit = BlockTransactionsListCubit(blockId: widget.blockId);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Text('Transactions', style: textTheme.headlineLarge),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          sliver: BlockTransactionsList(
            cubit: cubit,
          ),
        ),
      ],
    );
  }
}
