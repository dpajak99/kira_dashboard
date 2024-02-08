import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/utils/signature_utils.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class SignTransactionDialog extends DialogContentWidget {
  final String message;

  const SignTransactionDialog({
    required this.message,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignTransactionDialog();
}

class _SignTransactionDialog extends State<SignTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Sign transaction',
      width: 420,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xff06070a),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                Text(
                  widget.message,
                  style: textTheme.bodyMedium!.copyWith(color: const Color(0xff6c86ad)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: darkElevatedButton,
              onPressed: () {
                String sig = SignatureUtils.generateSignature(wallet: getIt<WalletProvider>().value as Wallet, message: widget.message);
                Navigator.of(context).pop(sig);
              },
              child: const Text('Approve'),
            ),
          ),
        ],
      ),
    );
  }
}
