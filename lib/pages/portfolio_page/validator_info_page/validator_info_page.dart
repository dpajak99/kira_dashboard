import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/staking_pool.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog.dart';
import 'package:kira_dashboard/pages/portfolio_page/validator_info_page/validator_info_page_cubit.dart';
import 'package:kira_dashboard/pages/portfolio_page/validator_info_page/validator_info_page_state.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_card.dart';
import 'package:kira_dashboard/widgets/openable_text.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/sliver_custom_card.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../utils/router/router.gr.dart';

class ValidatorInfoPage extends StatefulWidget {
  final Validator validator;

  const ValidatorInfoPage({
    super.key,
    required this.validator,
  });

  @override
  State<StatefulWidget> createState() => _ValidatorInfoPageState();
}

class _ValidatorInfoPageState extends State<ValidatorInfoPage> {
  late final ValidatorInfoPageCubit cubit =
      ValidatorInfoPageCubit(validator: widget.validator);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidatorInfoPageCubit, ValidatorInfoPageState>(
      bloc: cubit,
      builder: (BuildContext context, ValidatorInfoPageState state) {
        Widget stakingPoolWidget = _StakingPoolWidget(
          validator: widget.validator,
          isLoading: state.isLoading,
          stakingPool: state.stakingPool,
        );

        Widget statsWidget = _StatsWidget(validator: widget.validator);

        if (MediaQuery.of(context).size.width < 900) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                stakingPoolWidget,
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                statsWidget,
              ],
            ),
          );
        }
        return SliverToBoxAdapter(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: stakingPoolWidget),
              const SizedBox(width: 32),
              Expanded(child: statsWidget),
            ],
          ),
        );
      },
    );
  }
}

class _StatsWidget extends StatelessWidget {
  final Validator validator;

  const _StatsWidget({
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomCard(
      title: 'Stats',
      titleSpacing: 8,
      titleStyle: textTheme.titleMedium!.copyWith(
        color: CustomColors.white,
      ),
      child: Column(
        children: [
          const Divider(color: CustomColors.divider),
          const SizedBox(height: 8),
          _ListTile(
            title: 'First present block',
            value: OpenableText(
              text: validator.startHeight.toString(),
              style: textTheme.bodyMedium!.copyWith(
                color: CustomColors.white,
              ),
              onTap: () => AutoRouter.of(context).push(
                  BlockDetailsRoute(height: validator.startHeight.toString())),
            ),
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Last present block',
            value: OpenableText(
              text: validator.lastPresentBlock.toString(),
              style: textTheme.bodyMedium!.copyWith(
                color: CustomColors.white,
              ),
              onTap: () => AutoRouter.of(context).push(BlockDetailsRoute(
                  height: validator.lastPresentBlock.toString())),
            ),
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Status',
            value: validator.status.name,
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Total produced blocks',
            value: validator.producedBlocksCounter.toString(),
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Produced blocks streak',
            value: validator.streak.toString(),
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Missed blocks',
            value: validator.mischanceConfidence.toString(),
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Mischance',
            value: validator.mischance.toString(),
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Mischance confidence',
            value: validator.mischanceConfidence.toString(),
          ),
        ],
      ),
    );
  }
}

class _StakingPoolWidget extends StatelessWidget {
  final Validator validator;
  final bool isLoading;
  final StakingPool? stakingPool;

  const _StakingPoolWidget({
    required this.validator,
    required this.isLoading,
    required this.stakingPool,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomCard(
      title: 'Staking pool',
      titleSpacing: 8,
      titleStyle: textTheme.titleMedium!.copyWith(
        color: CustomColors.white,
      ),
      leading: Row(
        children: [
          if (getIt<WalletProvider>().isSignedIn) ...<Widget>[
            SimpleTextButton(
              text: 'Delegate',
              onTap: () => DialogRouter().navigate(
                  DelegateTokensDialog(valoperAddress: validator.valkey)),
            ),
          ],
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: CustomColors.divider),
          const SizedBox(height: 8),
          _ListTile(
            title: 'Staking pool',
            value: isLoading
                ? const SizedShimmer(width: 80, height: 16)
                : validator.stakingPoolStatus.name,
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Commission',
            value: isLoading
                ? const SizedShimmer(width: 80, height: 16)
                : stakingPool!.commissionPercentage,
          ),
          const SizedBox(height: 12),
          _ListTile(
            title: 'Slashed',
            value: isLoading
                ? const SizedShimmer(width: 80, height: 16)
                : stakingPool!.slashedPercentage,
          ),
          const SizedBox(height: 8),
          const Divider(color: CustomColors.divider),
          const SizedBox(height: 8),
          Text(
            'Staked voting powers',
            style: textTheme.bodyMedium!.copyWith(
              color: CustomColors.secondary,
            ),
          ),
          if (isLoading) ...<Widget>[
            const SizedBox(height: 8),
            const SizedShimmer(width: 100, height: 30),
          ] else
            for (Coin coin in stakingPool!.votingPower)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                dense: true,
                leading: TokenIcon(size: 24, iconUrl: coin.icon),
                title: Text(
                  coin.name,
                  style:
                      textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                ),
                trailing: Text(
                  coin.toNetworkDenominationString(),
                  style: textTheme.bodyMedium!
                      .copyWith(color: CustomColors.secondary),
                ),
              ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final dynamic value;

  const _ListTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium!.copyWith(
            color: CustomColors.secondary,
          ),
        ),
        if (value is String)
          Text(
            value,
            style: textTheme.bodyMedium!.copyWith(
              color: CustomColors.white,
            ),
          )
        else
          value
      ],
    );
  }
}
