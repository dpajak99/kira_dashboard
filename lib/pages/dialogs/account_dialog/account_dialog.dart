import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class AccountDialog extends DialogContentWidget {
  const AccountDialog({super.key});

  @override
  State<StatefulWidget> createState() => _AccountDialog();
}

class _AccountDialog extends State<AccountDialog> {
  final WalletProvider walletProvider = getIt<WalletProvider>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Wallet?>(
      valueListenable: walletProvider,
      builder: (BuildContext context, Wallet? wallet, _) {
        if (wallet == null) {
          return const SizedBox();
        }
        return CustomDialog(
          title: 'Account',
          width: 420,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff06070a),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            AutoRouter.of(context).push(PortfolioRoute(address: wallet.address));
                          },
                          icon: const Icon(
                            Icons.open_in_new,
                            size: 20,
                            color: Color(0xff6c86ad),
                          ),
                          label: const Text(
                            'Open portfolio',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff6c86ad),
                            ),
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
                                walletProvider.signOut();
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
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IdentityAvatar(size: 90, address: wallet.address),
                          const SizedBox(height: 16),
                          CopyableAddressText(
                            address: wallet.address,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xfffbfbfb),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
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
                    const SizedBox(height: 24),
                    const Divider(color: Color(0xff222b3a)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text(
                          'Available accounts',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff6c86ad),
                          ),
                        ),
                        const Spacer(),
                        IconTextButton(
                          text: 'Add',
                          gap: 4,
                          reversed: true,
                          icon: Icons.add,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff4888f0),
                          ),
                          onTap: () => walletProvider.deriveNextWallet(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: walletProvider.availableWallets.length,
                      itemBuilder: (context, index) {
                        Wallet wallet = walletProvider.availableWallets[index];
                        return ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: IdentityAvatar(size: 40, address: wallet.address),
                          title: Text(
                            'Account ${wallet.index}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xfffbfbfb),
                            ),
                          ),
                          subtitle: CopyableAddressText(
                            address: wallet.address,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff6c86ad),
                            ),
                          ),
                          trailing: wallet != walletProvider.value ? IconTextButton(
                            text: 'Switch',
                            gap: 4,
                            reversed: true,
                            icon: Icons.login,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff4888f0),
                            ),
                            onTap: () => walletProvider.changeWallet(wallet)
                          ) : null,
                        );
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
