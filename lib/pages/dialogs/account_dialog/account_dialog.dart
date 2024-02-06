import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/account_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/account_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/wallet_info.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class AccountDialog extends DialogContentWidget {
  const AccountDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AccountDialog();
}

class _AccountDialog extends State<AccountDialog> {
  final AccountDialogCubit cubit = getIt<AccountDialogCubit>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AccountDialogCubit, AccountDialogState>(
      bloc: cubit,
      builder: (BuildContext context, AccountDialogState state) {
        return CustomDialog(
          title: 'Account',
          width: 420,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xff06070a),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                              AutoRouter.of(context).push(PortfolioRoute(address: state.selectedWallet!.address));
                            },
                            icon: const Icon(
                              Icons.open_in_new,
                              size: 20,
                              color: Color(0xff6c86ad),
                            ),
                            label: Text(
                              'Open portfolio',
                              style: textTheme.labelLarge!.copyWith(color: const Color(0xff6c86ad)),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.settings,
                                  color: Color(0xff6c86ad),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  cubit.signOut();
                                  AutoRouter.of(context).navigate(const MenuWrapperRoute());
                                },
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  color: Color(0xff6c86ad),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LabeledIconButton(
                            onPressed: () {
                              DialogRouter().navigate(const SendTokensDialog());
                            },
                            icon: const Icon(AppIcons.arrow_up_right),
                            label: 'Send',
                          ),
                          LabeledIconButton(
                            onPressed: () {},
                            icon: Transform.rotate(
                              angle: pi,
                              child: const Icon(AppIcons.arrow_up_right),
                            ),
                            label: 'Receive',
                          ),
                          const LabeledIconButton(
                            onPressed: null,
                            icon: Icon(Icons.swap_horiz),
                            label: 'Swap',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(color: Color(0xff222b3a)),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            'Available accounts',
                            style: textTheme.bodyMedium?.copyWith(color: const Color(0xff6c86ad)),
                          ),
                          const Spacer(),
                          IconTextButton(
                            text: 'Add',
                            gap: 4,
                            reversed: true,
                            icon: Icons.add,
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                            onTap: () => cubit.deriveNextWallet(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.walletInfos.length,
                      itemBuilder: (context, index) {
                        WalletInfo walletInfo = state.walletInfos[index];
                        bool isSelected = walletInfo.wallet.address == state.selectedWallet?.address;

                        Widget item = ListTile(
                          dense: true,
                          mouseCursor: MaterialStateMouseCursor.clickable,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onTap: () {
                            cubit.signIn(walletInfo.wallet);
                          },
                          contentPadding: const EdgeInsets.all(8),
                          leading: IdentityAvatar(size: 40, address: walletInfo.wallet.address),
                          title: Text(
                            'Account ${walletInfo.wallet.index}',
                            style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                          ),
                          subtitle: AddressText(
                            address: walletInfo.wallet.address,
                            style: textTheme.bodySmall!.copyWith(color: const Color(0xff6c86ad)),
                          ),
                          trailing: state.isLoading
                              ? const SizedShimmer(width: 40, height: 14)
                              : Text(
                                  walletInfo.coin?.toNetworkDenominationString() ?? '---',
                                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                                ),
                        );

                        if (isSelected) {
                          item = Container(
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xff222b3a),
                              borderRadius: BorderRadius.circular(8),
                              border: const Border(
                                left: BorderSide(
                                  color: Color(0xff4888f0),
                                  width: 4,
                                ),
                              ),
                            ),
                            child: item,
                          );
                        } else {
                          item = Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: item,
                              ),
                            ),
                          );
                        }

                        return item;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LabeledIconButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onPressed;

  const LabeledIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filledTonal(
          style: filledIconButton,
          onPressed: onPressed,
          icon: icon,
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
