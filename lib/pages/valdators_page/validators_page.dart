import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_cubit.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_state.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Validators',
                      style: textTheme.headlineLarge!.copyWith(color: appColors.onBackground),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Choose a validator to delegate your tokens and start earning rewards. Validators play a vital role in maintaining the network, and by staking with them, you contribute to the network's stability and earn a share of the rewards. Detailed information about each validator's performance, such as uptime and streak records, helps guide your decision. Your stake supports the validator's reliability while entitling you to rewards generated from block creation and transaction fees.",
                      style: textTheme.bodyMedium!.copyWith(color: appColors.secondary),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<ValidatorsPageCubit, ValidatorsPageState>(
          bloc: cubit,
          builder: (BuildContext context, ValidatorsPageState state) {
            return SliverGrid.builder(
              itemCount: state.validators.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 26,
                crossAxisSpacing: 26,
                maxCrossAxisExtent: (MediaQuery.of(context).size.width > 800) ? 275 : 550,
                mainAxisExtent: (MediaQuery.of(context).size.width > 800)
                    ? state.isSignedIn
                        ? 360
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      onTap: () => AutoRouter.of(context).navigate(PortfolioRoute(address: validator.address)),
      childBuilder: (Set<MaterialState> states) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: appColors.primaryContainer,
              border: Border.all(
                color: states.contains(MaterialState.hovered) ? appColors.outline : const Color(0xff141822),
                width: 2,
              ),
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
                        style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
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
                      CopyableAddressText(
                        address: validator.address,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Uptime',
                            style: textTheme.bodyMedium?.copyWith(color: appColors.secondary),
                          ),
                          const Spacer(),
                          Text(
                            '${validator.uptime}%',
                            style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Streak',
                            style: textTheme.bodyMedium?.copyWith(color: appColors.secondary),
                          ),
                          const Spacer(),
                          Text(
                            validator.streak,
                            style: textTheme.bodyMedium?.copyWith(color: appColors.onBackground),
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: 72,
      height: 32,
      decoration: BoxDecoration(
        color: appColors.primary,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
      ),
      child: Center(
        child: Text(
          'Rank #$rank',
          style: textTheme.labelMedium!.copyWith(color: appColors.onBackground),
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: switch (status) {
          ValidatorStatus.active => CustomColors.green,
          ValidatorStatus.inactive => CustomColors.yellow,
          ValidatorStatus.jailed => CustomColors.red,
          ValidatorStatus.paused => CustomColors.yellow,
        }.withOpacity(0.3),
      ),
      child: Text(
        switch (status) {
          ValidatorStatus.active => 'Active validator',
          ValidatorStatus.inactive => 'Inactive validator',
          ValidatorStatus.jailed => 'Jailed validator',
          ValidatorStatus.paused => 'Paused validator',
        },
        style: textTheme.labelMedium!.copyWith(
          color: switch (status) {
            ValidatorStatus.active => CustomColors.green,
            ValidatorStatus.inactive => CustomColors.yellow,
            ValidatorStatus.jailed => CustomColors.red,
            ValidatorStatus.paused => CustomColors.yellow,
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: switch (status) {
          StakingPoolStatus.withdraw => CustomColors.yellow,
          StakingPoolStatus.disabled => CustomColors.red,
          StakingPoolStatus.enabled => CustomColors.green,
        }.withOpacity(0.3),
      ),
      child: Text(
        switch (status) {
          StakingPoolStatus.withdraw => 'WITHDRAW',
          StakingPoolStatus.disabled => 'Staking disabled',
          StakingPoolStatus.enabled => 'Staking enabled',
        },
        style: textTheme.labelMedium!.copyWith(
          color: switch (status) {
            StakingPoolStatus.withdraw => CustomColors.yellow,
            StakingPoolStatus.disabled => CustomColors.red,
            StakingPoolStatus.enabled => CustomColors.green,
          },
        ),
      ),
    );
  }
}
