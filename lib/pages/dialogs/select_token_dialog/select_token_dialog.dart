import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/select_token_dialog/select_token_dialog_cubit.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/infinity_list_cubit.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/popup_infinity_list.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class SelectTokenDialog extends DialogContentWidget {
  final String address;

  const SelectTokenDialog({super.key, required this.address});

  @override
  State<StatefulWidget> createState() => _SelectTokenDialogState();
}

class _SelectTokenDialogState extends State<SelectTokenDialog> {
  final ScrollController scrollController = ScrollController();
  late final SelectTokenDialogCubit cubit = SelectTokenDialogCubit(
    address: widget.address,
    scrollController: scrollController,
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Select token',
      width: 420,
      contentPadding: EdgeInsets.zero,
      child: PopupInfinityList<Coin>(
        cubit: cubit,
        scrollController: scrollController,
        elementBuilder: (BuildContext context, Coin? balance, bool loading) {
          if (balance == null) {
            return const SizedShimmer(width: double.infinity, height: 40);
          }
          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => DialogRouter().navigateBack(balance),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  dense: true,
                  leading: TokenIcon(size: 24, iconUrl: balance.icon),
                  title: Text(
                    balance.name,
                    style: textTheme.titleLarge!.copyWith(color: const Color(0xfffbfbfb)),
                  ),
                  subtitle: Text(
                    balance.toNetworkDenominationString(),
                    style: textTheme.labelLarge!.copyWith(color: const Color(0xff6c86ad)),
                  ),
                  trailing: const Icon(
                    AppIcons.chevron_right,
                    color: Color(0xff6c86ad),
                    size: 16,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
