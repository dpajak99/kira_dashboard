import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

enum TransactionProcessStatus {
  broadcast,
  success,
  failed,
}

class TransactionResultDialog extends DialogContentWidget {
  final TransactionProcessStatus status;

  const TransactionResultDialog({
    super.key,
    this.status = TransactionProcessStatus.broadcast,
  });

  @override
  State<StatefulWidget> createState() => _TransactionResultDialogState();
}

class _TransactionResultDialogState extends State<TransactionResultDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: switch (widget.status) {
        TransactionProcessStatus.broadcast => 'Broadcasting transaction',
        TransactionProcessStatus.success => 'Transaction sent',
        TransactionProcessStatus.failed => 'Transaction failed',
      },
      width: 420,
      scrollable: false,
      child: Column(
        children: [
          const SizedBox(height: 48),
          SizedBox(
            width: 90,
            height: 90,
            child: switch (widget.status) {
              TransactionProcessStatus.broadcast => const CircularProgressIndicator(
                  color: Color(0xff2f8af5),
                  strokeWidth: 2,
                ),
              TransactionProcessStatus.success => const Icon(
                  Icons.done,
                  size: 90,
                  color: Color(0xff59b987),
                ),
              TransactionProcessStatus.failed => const Icon(
                  Icons.close,
                  size: 90,
                  color: Color(0xffe74c3c),
                ),
            },
          ),
          const SizedBox(height: 40),
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
