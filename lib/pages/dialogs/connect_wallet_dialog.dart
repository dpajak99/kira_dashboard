import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/dialogs/create_wallet_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';

class ConnectWalletDialog extends DialogContentWidget {
  const ConnectWalletDialog({super.key});

  @override
  String get title => 'Connect Wallet';

  @override
  State<StatefulWidget> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<ConnectWalletDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _OptionItem(
                leading: Icons.abc,
                onTap: () => CustomDialogRoute.of(context).navigate(const SignInMnemonicDialog()),
                title: 'Mnemonic',
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: _OptionItem(
                leading: Icons.file_upload_outlined,
                title: 'Keyfile',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => CustomDialogRoute.of(context).navigate(const CreateWalletDialog()),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wallet,
                color: Color(0xff4888f0),
              ),
              SizedBox(width: 8),
              Text(
                "Create Wallet",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff4888f0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        RichText(
          text: const TextSpan(
            text: 'By connecting your wallet, you agree to\nour ',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff6c86ad),
            ),
            children: [
              TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  color: Color(0xff2f8af5),
                ),
              ),
              TextSpan(
                text: ' and ',
                style: TextStyle(color: Color(0xff6c86ad)),
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  color: Color(0xff2f8af5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OptionItem extends StatelessWidget {
  final IconData leading;
  final String title;
  final VoidCallback? onTap;

  const _OptionItem({
    required this.leading,
    required this.title,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xff10141C),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.fromBorderSide(
              BorderSide(
                color: states.contains(MaterialState.hovered) ? const Color(0xff2f3b4d) : Colors.transparent,
              ),
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                leading,
                color: states.contains(MaterialState.hovered) ? const Color(0xff2f8af5) : const Color(0xfffbfbfb),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: states.contains(MaterialState.hovered) ? const Color(0xff2f8af5) : const Color(0xfffbfbfb),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
