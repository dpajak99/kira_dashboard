import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class ConfirmTransactionDialog extends DialogContentWidget {
  const ConfirmTransactionDialog({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ConfirmTransactionDialog();
}

class _ConfirmTransactionDialog extends State<ConfirmTransactionDialog> {

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Confirm transaction',
      width: 420,
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
            'Please, confirm transaction in your wallet',
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
