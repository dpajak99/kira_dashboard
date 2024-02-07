import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_list.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
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
    return PageScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: CustomCard(
            title: 'Proposals',
            enableMobile: true,
            childPadding: EdgeInsets.zero,
            child: ProposalsList(cubit: cubit),
          ),
        ),
      ],
    );
  }
}
