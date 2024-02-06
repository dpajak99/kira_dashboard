import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/create_wallet_dialog/create_wallet_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';

class ConnectWalletDialog extends DialogContentWidget {
  const ConnectWalletDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<ConnectWalletDialog> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Connect Wallet',
      width: 550,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: signupButtonStyle,
                  icon: const Icon(Icons.abc),
                  onPressed: () => DialogRouter().navigate(const SignInMnemonicDialog()),
                  label: const Text('Mnemonic'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.file_upload_outlined),
                  style: signupButtonStyle,
                  onPressed: (){},
                  label: const Text('Keyfile'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () => DialogRouter().navigate(const CreateWalletDialog()),
            style: lightTextButtonStyle,
            icon: const Icon(
              Icons.wallet,
              color: Color(0xff4888f0),
            ),
            label: const Text("Create Wallet"),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              text: 'By connecting your wallet, you agree to\nour ',
              style: textTheme.labelLarge!.copyWith(color: const Color(0xff6c86ad)),
              children: const [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(color: Color(0xff2f8af5)),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(color: Color(0xff6c86ad)),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: Color(0xff2f8af5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
