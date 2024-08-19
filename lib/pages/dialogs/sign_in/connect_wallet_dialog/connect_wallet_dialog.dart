import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/create_wallet_dialog/create_wallet_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_keyfile_dialog/sign_in_keyfile_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog.dart';
import 'package:kira_dashboard/utils/keplr.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class ConnectWalletDialog extends DialogContentWidget {
  const ConnectWalletDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<ConnectWalletDialog> {
  final KeplrImpl keplr = KeplrImpl();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Connect Wallet',
      width: 550,
      child: Column(
        children: [
          Text(
            'Connect your wallet to access your account',
            style: textTheme.bodySmall!.copyWith(color: CustomColors.secondary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: IgnorePointer(
                  ignoring: keplr.isExtensionInstalled == false,
                  child: Opacity(
                    opacity: keplr.isExtensionInstalled == false ? 0.5 : 1,
                    child: ElevatedButton.icon(
                      style: signupButtonStyle,
                      icon: SizedBox(
                        width: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'icons/keplr.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      onPressed: _openKeplr,
                      label: Row(
                        children: [
                          const Text('Keplr'),
                          const Spacer(),
                          if (keplr.isExtensionInstalled == false) const Icon(Icons.lock_outline_rounded, size: 15)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Unsafe options',
            style: textTheme.bodySmall!.copyWith(color: CustomColors.secondary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: signupButtonStyle,
                  icon: const SizedBox(
                    width: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.abc),
                    ),
                  ),
                  onPressed: () => DialogRouter().navigate(const SignInMnemonicDialog()),
                  label: const Text('Mnemonic'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const SizedBox(
                    width: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.file_upload_outlined),
                    ),
                  ),
                  style: signupButtonStyle,
                  onPressed: () => DialogRouter().navigate(const SignInKeyfileDialog()),
                  label: const Text('Keyfile'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () => DialogRouter().navigate(const CreateWalletDialog()),
            style: lightTextButtonStyle,
            icon: const Icon(Icons.wallet, color: CustomColors.primary),
            label: const Text("Create Wallet"),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              text: 'By connecting your wallet, you agree to\nour ',
              style: textTheme.labelLarge!.copyWith(color: CustomColors.secondary),
              children: const [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(color: CustomColors.primary),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(color: CustomColors.primary),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: CustomColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openKeplr() async {
    KeplrImpl keplr = KeplrImpl();
    List<KeplrWallet> wallets = await keplr.getAccount();
    if (wallets.isNotEmpty) {
      getIt<WalletProvider>().signIn(wallets.first);
      _closeDialog();
    }
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }
}
