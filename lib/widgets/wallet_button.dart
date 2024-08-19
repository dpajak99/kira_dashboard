import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/account_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/connect_wallet_dialog/connect_wallet_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';

class WalletButton extends StatelessWidget {
  final bool small;

  const WalletButton({
    super.key,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<IWallet?>(
      valueListenable: getIt<WalletProvider>(),
      builder: (BuildContext context, IWallet? wallet, _) {
        if (wallet == null) {
          return _ConnectWalletButton(small: small);
        } else {
          return _WalletButton(wallet: wallet, small: small);
        }
      },
    );
  }
}

class _ConnectWalletButton extends StatelessWidget {
  final bool small;

  const _ConnectWalletButton({
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (small) {
      return IconButton(
        onPressed: () => DialogRouter().navigate(const ConnectWalletDialog()),
        icon: const Icon(Icons.wallet, color: CustomColors.primary),
      );
    }
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: () => DialogRouter().navigate(const ConnectWalletDialog()),
      child: Container(
        decoration: const BoxDecoration(
          color: CustomColors.appBarContainer,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            const Icon(Icons.wallet, color: CustomColors.primary),
            const SizedBox(width: 8),
            Text(
              "Connect Wallet",
              style: textTheme.titleLarge!.copyWith(color: CustomColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletButton extends StatelessWidget {
  final IWallet wallet;
  final bool small;

  const _WalletButton({
    required this.wallet,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (small) {
      return IconButton(
        onPressed: () => DialogRouter().navigate(const AccountDialog()),
        icon: IdentityAvatar(size: 35, address: wallet.address),
      );
    }
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: () => DialogRouter().navigate(const AccountDialog()),
      child: Container(
        decoration: const BoxDecoration(
          color: CustomColors.dialog,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            if (wallet is KeplrWallet) ...<Widget>[
              SvgPicture.asset(
                'icons/keplr.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
            ],
            IdentityAvatar(size: 20, address: wallet.address),
            const SizedBox(width: 12),
            Text(
              '${wallet.address.substring(0, 8)}...${wallet.address.substring(wallet.address.length - 4)}',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
