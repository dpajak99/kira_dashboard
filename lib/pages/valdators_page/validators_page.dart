import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/valdators_page/validator_list.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_list_cubit.dart';
import 'package:kira_dashboard/widgets/page_scaffold.dart';

@RoutePage()
class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ValidatorsPageState();
}

class _ValidatorsPageState extends State<ValidatorsPage> {
  final ValidatorsListCubit cubit = ValidatorsListCubit();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageScaffold(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                        style: textTheme.headlineLarge!.copyWith(color: CustomColors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Choose a validator to delegate your tokens and start earning rewards. Validators play a vital role in maintaining the network, and by staking with them, you contribute to the network's stability and earn a share of the rewards. Detailed information about each validator's performance, such as uptime and streak records, helps guide your decision. Your stake supports the validator's reliability while entitling you to rewards generated from block creation and transaction fees.",
                        style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          sliver: ValidatorList(cubit: cubit),
        ),
      ],
    );
  }
}
