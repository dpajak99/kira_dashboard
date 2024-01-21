import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/connect_wallet_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';

class WalletButton extends StatelessWidget {
  const WalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Wallet?>(
      valueListenable: getIt<WalletProvider>(),
      builder: (BuildContext context, Wallet? wallet, _) {
        if (wallet == null) {
          return const _ConnectWalletButton();
        } else {
          return _WalletButton(wallet: wallet);
        }
      },
    );
  }
}

class _ConnectWalletButton extends StatelessWidget {
  const _ConnectWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: () => showDialog(context: context, builder: (BuildContext context) => const CustomDialogRoute(content: ConnectWalletDialog())),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff101c2e),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: const Row(
          children: [
            Icon(
              Icons.wallet,
              color: Color(0xff4888f0),
            ),
            SizedBox(width: 8),
            Text(
              "Connect Wallet",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff4888f0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletButton extends StatelessWidget {
  final Wallet wallet;

  const _WalletButton({
    required this.wallet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: () => AutoRouter.of(context).navigate(PortfolioRoute(address: wallet.address)),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff324054),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            IdentityAvatar(size: 20, address: wallet.address),
            const SizedBox(width: 12),
            Text('${wallet.address.substring(0, 8)}...${wallet.address.substring(wallet.address.length - 4)}'),
          ],
        ),
      ),
    );
  }
}
