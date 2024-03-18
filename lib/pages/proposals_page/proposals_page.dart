import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_list.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_list_cubit.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';

@RoutePage()
class ProposalsPage extends StatefulWidget {
  const ProposalsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  final ProposalsListCubit cubit = ProposalsListCubit();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Text('Proposals', style: textTheme.headlineLarge),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          sliver: ProposalsList(cubit: cubit),
        ),
      ],
    );
  }
}
