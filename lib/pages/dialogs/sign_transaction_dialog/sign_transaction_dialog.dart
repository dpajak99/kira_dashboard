import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class SignTransactionDialog extends DialogContentWidget {
  const SignTransactionDialog({super.key});

  @override
  State<StatefulWidget> createState() => _SignTransactionDialog();
}

class _SignTransactionDialog extends State<SignTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Sign transaction',
      width: 420,
      scrollable: false,
      child: Column(
        children: [
          const SizedBox(height: 48),
          const SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(
              color: Color(0xff2f8af5),
              strokeWidth: 2,
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            'Please, sign transaction in your wallet',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff6c86ad),
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: lightElevatedButton,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }
}
