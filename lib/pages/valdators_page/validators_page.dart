import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_cubit.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';

@RoutePage()
class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ValidatorsPageState();
}

class _ValidatorsPageState extends State<ValidatorsPage> {
  late final ValidatorsPageCubit cubit = ValidatorsPageCubit();

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      slivers: [
        const SliverToBoxAdapter(
          child: Text(
            'Validators',
            style: TextStyle(
              fontSize: 32,
              color: Color(0xfffbfbfb),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 4)),
        const SliverToBoxAdapter(
          child: Text(
            "Choose a validator to delegate your tokens and start earning rewards. Validators play a vital role in maintaining the network, and by staking with them, you contribute to the network's stability and earn a share of the rewards. Detailed information about each validator's performance, such as uptime and streak records, helps guide your decision. Your stake supports the validator's reliability while entitling you to rewards generated from block creation and transaction fees.",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff6c86ad),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 32)),
        BlocBuilder<ValidatorsPageCubit, ValidatorsPageState>(
          bloc: cubit,
          builder: (BuildContext context, ValidatorsPageState state) {
            return SliverGrid.builder(
              itemCount: state.validators.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                maxCrossAxisExtent: (MediaQuery.of(context).size.width > 800) ? 350 : 550,
                mainAxisExtent: (MediaQuery.of(context).size.width > 800)
                    ? state.isSignedIn
                        ? 400
                        : 340
                    : state.isSignedIn
                        ? 400
                        : 350,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _ValidatorTile(
                  validator: state.validators[index],
                  signedIn: state.isSignedIn,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _ValidatorTile extends StatelessWidget {
  final Validator validator;
  final bool signedIn;

  const _ValidatorTile({
    required this.validator,
    required this.signedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      childBuilder: (Set<MaterialState> states) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff141822),
              border: Border.all(color: states.contains(MaterialState.hovered) ? const Color(0xff6c86ad) : const Color(0xff141822), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _RankBookmark(rank: validator.top),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      IdentityAvatar(
                        size: 78,
                        address: validator.address,
                        avatarUrl: validator.logo,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        validator.moniker,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xfffbfbfb),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _ValidatorStatusChip(validator.status),
                            _PoolStatusChip(validator.stakingPoolStatus),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      OpenableAddressText(
                        address: validator.address,
                        style: const TextStyle(
                          color: Color(0xff6c86ad),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xff222b3a)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Uptime',
                            style: TextStyle(
                              color: Color(0xff6c86ad),
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${validator.uptime}%',
                            style: const TextStyle(
                              color: Color(0xfffbfbfb),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Streak',
                            style: TextStyle(
                              color: Color(0xff6c86ad),
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            validator.streak,
                            style: const TextStyle(
                              color: Color(0xfffbfbfb),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      if (signedIn) ...<Widget>[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => DialogRouter().navigate(DelegateTokensDialog(
                              valoperAddress: validator.valkey,
                            )),
                            child: const Text('Delegate'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RankBookmark extends StatelessWidget {
  final int rank;

  const _RankBookmark({required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xff4888f0),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(16)),
      ),
      child: Center(
        child: Text(
          'Rank #$rank',
          style: const TextStyle(
            color: Color(0xfffbfbfb),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _ValidatorStatusChip extends StatelessWidget {
  final ValidatorStatus status;

  const _ValidatorStatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: switch (status) {
          ValidatorStatus.active => const Color(0x2959b987),
          ValidatorStatus.inactive => const Color(0x29ffa500),
          ValidatorStatus.jailed => const Color(0x29f12e1f),
          ValidatorStatus.paused => const Color(0x29ffa500),
        },
      ),
      child: Text(
        switch (status) {
          ValidatorStatus.active => 'Active validator',
          ValidatorStatus.inactive => 'Inactive validator',
          ValidatorStatus.jailed => 'Jailed validator',
          ValidatorStatus.paused => 'Paused validator',
        },
        style: TextStyle(
          fontSize: 12,
          color: switch (status) {
            ValidatorStatus.active => const Color(0xff59b987),
            ValidatorStatus.inactive => const Color(0xffffa500),
            ValidatorStatus.jailed => const Color(0xfff12e1f),
            ValidatorStatus.paused => const Color(0xffffa500),
          },
        ),
      ),
    );
  }
}

class _PoolStatusChip extends StatelessWidget {
  final StakingPoolStatus status;

  const _PoolStatusChip(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: switch (status) {
          StakingPoolStatus.withdraw => const Color(0x29ffa500),
          StakingPoolStatus.disabled => const Color(0x29f12e1f),
          StakingPoolStatus.enabled => const Color(0x2959b987),
        },
      ),
      child: Text(
        switch (status) {
          StakingPoolStatus.withdraw => 'WITHDRAW',
          StakingPoolStatus.disabled => 'Staking disabled',
          StakingPoolStatus.enabled => 'Staking enabled',
        },
        style: TextStyle(
          fontSize: 12,
          color: switch (status) {
            StakingPoolStatus.withdraw => const Color(0xffffa500),
            StakingPoolStatus.disabled => const Color(0xfff12e1f),
            StakingPoolStatus.enabled => const Color(0xff59b987),
          },
        ),
      ),
    );
  }
}
