import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/blocks_page/blocks_list.dart';
import 'package:kira_dashboard/pages/blocks_page/blocks_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';

@RoutePage()
class BlocksPage extends StatefulWidget {
  const BlocksPage({super.key});

  @override
  State<StatefulWidget> createState() => _BlocksPageState();
}

class _BlocksPageState extends State<BlocksPage> {
  final BlocksListCubit cubit = BlocksListCubit();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Text('Blocks', style: textTheme.headlineLarge),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          sliver: BlocksList(
            cubit: cubit,
          ),
        ),
      ],
    );
  }
}
