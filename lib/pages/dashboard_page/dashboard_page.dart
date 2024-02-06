import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/dashboard_model.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dashboard_page/dashboard_page_cubit.dart';
import 'package:kira_dashboard/pages/dashboard_page/dashboard_page_state.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardPageCubit cubit = DashboardPageCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardPageCubit, DashboardPageState>(
      bloc: cubit,
      builder: (BuildContext context, DashboardPageState state) {
        Widget blocks = _DashboardCard(
          title: 'Blocks',
          columns: MediaQuery.of(context).size.width < 450 ? 1 : 2,
          values: [
            _DashboardTile(
              title: 'Current height',
              value: state.dashboard?.blocks.currentHeight.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Since genesis',
              value: state.dashboard?.blocks.sinceGenesis.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Pending transactions',
              value: state.dashboard?.blocks.pendingTransactions.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Current transactions',
              value: state.dashboard?.blocks.currentTransactions.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Latest time',
              value: state.dashboard?.blocks.latestTime.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Average time',
              value: state.dashboard?.blocks.averageTime.toString() ?? '',
            ),
          ],
        );

        Widget proposals = _DashboardCard(
          title: 'Proposals',
          columns: MediaQuery.of(context).size.width < 450 ? 1 : 2,
          values: [
            _DashboardTile(
              title: 'Active',
              value: state.dashboard != null ? '${state.dashboard?.proposals.active}/${state.dashboard?.proposals.total}' : '',
            ),
            _DashboardTile(
              title: 'Enacting',
              value: state.dashboard?.proposals.enacting.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Finished',
              value: state.dashboard?.proposals.finished.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Successful',
              value: state.dashboard?.proposals.successful.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Proposers',
              value: state.dashboard?.proposals.proposers.toString() ?? '',
            ),
            _DashboardTile(
              title: 'Voters',
              value: state.dashboard?.proposals.voters.toString() ?? '',
            ),
          ],
        );

        return PageScaffold(
          slivers: [
            if (MediaQuery.of(context).size.width > 900)
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        child: _DashboardTile(
                          title: 'Current block validator',
                          value: state.dashboard?.currentBlockValidator.moniker ?? '',
                          icon: const Icon(
                            AppIcons.block,
                            color: Color(0xff4888f0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomCard(
                        child: _DashboardTile(
                          title: 'Consensus',
                          value: state.dashboard?.consensusHealthPercentage ?? '',
                          icon: const Icon(
                            AppIcons.consensus,
                            color: Color(0xff4888f0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: CustomCard(
                        child: _DashboardTile(
                          title: 'Consensus state',
                          value: switch (state.dashboard?.consensusStateType) {
                            ConsensusStateType.healthy => 'Healthy',
                            ConsensusStateType.unhealthy => 'Unhealthy',
                            (_) => '',
                          },
                          icon: const Icon(
                            AppIcons.health,
                            color: Color(0xff4888f0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomCard(
                      child: _DashboardTile(
                        title: 'Current block validator',
                        value: state.dashboard?.currentBlockValidator.moniker ?? '',
                        icon: const Icon(
                          AppIcons.block,
                          color: Color(0xff4888f0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomCard(
                      child: _DashboardTile(
                        title: 'Consensus',
                        value: state.dashboard?.consensusHealthPercentage ?? '',
                        icon: const Icon(
                          AppIcons.consensus,
                          color: Color(0xff4888f0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomCard(
                      child: _DashboardTile(
                        title: 'Consensus state',
                        value: switch (state.dashboard?.consensusStateType) {
                          ConsensusStateType.healthy => 'Healthy',
                          ConsensusStateType.unhealthy => 'Unhealthy',
                          (_) => '',
                        },
                        icon: const Icon(
                          AppIcons.health,
                          color: Color(0xff4888f0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(top: 40)),
            SliverToBoxAdapter(
              child: _DashboardCard(
                columns: switch (MediaQuery.of(context).size.width) {
                  < 600 => 2,
                  < 900 => 3,
                  (_) => 6,
                },
                title: 'Validators',
                values: [
                  _DashboardTile(
                    title: 'Total',
                    value: state.dashboard?.validators.totalValidators.toString() ?? '',
                  ),
                  _DashboardTile(
                    title: 'Active',
                    value: state.dashboard?.validators.activeValidators.toString() ?? '',
                  ),
                  _DashboardTile(
                    title: 'Paused',
                    value: state.dashboard?.validators.pausedValidators.toString() ?? '',
                  ),
                  _DashboardTile(
                    title: 'Inactive',
                    value: state.dashboard?.validators.inactiveValidators.toString() ?? '',
                  ),
                  _DashboardTile(
                    title: 'Jailed',
                    value: state.dashboard?.validators.jailedValidators.toString() ?? '',
                  ),
                  _DashboardTile(
                    title: 'Waiting',
                    value: state.dashboard?.validators.waitingValidators.toString() ?? '',
                  ),
                ],
              ),
            ),
            if (MediaQuery.of(context).size.width > 900)
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(child: blocks),
                    const SizedBox(width: 40),
                    Expanded(child: proposals),
                  ],
                ),
              )
            else ...<Widget>[
              SliverToBoxAdapter(child: blocks),
              const SliverPadding(padding: EdgeInsets.only(top: 40)),
              SliverToBoxAdapter(child: proposals),
            ]
          ],
        );
      },
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final int columns;
  final List<Widget> values;

  const _DashboardCard({
    super.key,
    required this.title,
    required this.columns,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.headlineMedium!.copyWith(color: const Color(0xfffbfbfb)),
          ),
          const SizedBox(height: 20),
          CustomCard(
            child: Column(
              children: [
                for (int i = 0; i < values.length ~/ columns; i++)
                  Row(
                    children: [
                      for (int j = 0; j < columns; j++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: values[i * columns + j],
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String title;
  final String value;
  final Icon? icon;

  const _DashboardTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium!.copyWith(color: const Color(0xfffbfbfb)),
        ),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
        ),
      ],
    );

    if (icon != null) {
      child = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: icon?.color?.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: icon!,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(child: child),
        ],
      );
    }

    return child;
  }
}
