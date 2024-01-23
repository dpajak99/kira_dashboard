import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class TransactionResultDialog extends DialogContentWidget {
  final bool succeeded;

  const TransactionResultDialog({
    super.key,
    this.succeeded = true,
  });

  @override
  State<StatefulWidget> createState() => _TransactionResultDialogState();
}

class _TransactionResultDialogState extends State<TransactionResultDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: widget.succeeded ? 'Transaction sent' : 'Transaction failed',
      width: 420,
      scrollable: false,
      child: Column(
        children: [
          const SizedBox(height: 48),
          if (widget.succeeded)
            const SizedBox(
              width: 90,
              height: 90,
              child: Icon(
                Icons.done,
                size: 90,
                color: Color(0xff59b987),
              ),
            )
          else
            const SizedBox(
              width: 90,
              height: 90,
              child: Icon(
                Icons.close,
                size: 90,
                color: Color(0xffe74c3c),
              ),
            ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Show transaction'),
            ),
          ),
          const SizedBox(height: 16),
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
