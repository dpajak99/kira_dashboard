import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/portfolio_page/portfolio_page_state.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/custom_table.dart';

class DelegationsPage extends StatelessWidget {
  final PortfolioPageState state;

  const DelegationsPage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: 'Undelegations',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTable<Undelegation>(
                items: state.undelegations,
                columns: <ColumnConfig<Undelegation>>[
                  ColumnConfig(
                    title: 'Validator',
                    cellBuilder: (BuildContext context, Undelegation item) {
                      return Row(
                        children: <Widget>[
                          IdentityAvatar(size: 32, address: item.validatorInfo.address),
                          const SizedBox(width: 12),
                          Expanded(child: Text(item.validatorInfo.moniker, style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)))),
                        ],
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Amount',
                    cellBuilder: (BuildContext context, Undelegation item) {
                      return Text(
                        item.amounts.map((e) => e.toNetworkDenominationString()).join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Expiry',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, Undelegation item) {
                      return Text(
                        DateFormat('d MMM y, HH:mm').format(item.expiry),
                        style: TextStyle(
                          fontSize: 14,
                          color: item.expiry.difference(DateTime.now()).inSeconds > 0 ? const Color(0xfff12e1f) : const Color(0xff35b15f),
                        ),
                        textAlign: TextAlign.right,
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Actions',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, Undelegation item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline, size: 20, color: Color(0xff2f8af5)),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        CustomCard(
          title: 'Delegations',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTable<Delegation>(
                items: state.delegations,
                columns: <ColumnConfig<Delegation>>[
                  ColumnConfig(
                    title: 'Validator',
                    cellBuilder: (BuildContext context, Delegation item) {
                      return Row(
                        children: <Widget>[
                          IdentityAvatar(size: 32, address: item.validatorInfo.address),
                          const SizedBox(width: 12),
                          Expanded(child: Text(item.validatorInfo.moniker, style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)))),
                        ],
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Status',
                    cellBuilder: (BuildContext context, Delegation item) {
                      return _StatusChip(stakingPoolStatus: item.poolInfo.status);
                    },
                  ),
                  ColumnConfig(
                    title: 'Commission',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, Delegation item) {
                      return Text(
                        '${item.poolInfo.commissionPercentage}%',
                        style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                        textAlign: TextAlign.right,
                      );
                    },
                  ),
                  ColumnConfig(
                    title: 'Actions',
                    textAlign: TextAlign.right,
                    cellBuilder: (BuildContext context, Delegation item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.info_outline, size: 20, color: Color(0xff2f8af5)),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final StakingPoolStatus stakingPoolStatus;

  const _StatusChip({required this.stakingPoolStatus});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: switch (stakingPoolStatus) {
            StakingPoolStatus.disabled => const Color(0x29f12e1f),
            StakingPoolStatus.enabled => const Color(0x2935b15f),
            StakingPoolStatus.withdraw => const Color(0x29ffa500),
          },
        ),
        child: Text(
          switch (stakingPoolStatus) {
            StakingPoolStatus.disabled => 'Disabled',
            StakingPoolStatus.enabled => 'Enabled',
            StakingPoolStatus.withdraw => 'Withdraw only'
          },
          style: TextStyle(
            fontSize: 12,
            color: switch (stakingPoolStatus) {
              StakingPoolStatus.disabled => const Color(0xfff12e1f),
              StakingPoolStatus.enabled => const Color(0xff35b15f),
              StakingPoolStatus.withdraw => const Color(0xffffa500),
            },
          ),
        ),
      ),
    );
  }
}
