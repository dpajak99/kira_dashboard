import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';

class SendTransactionDialog extends DialogContentWidget {
  const SendTransactionDialog({super.key});

  @override
  String get title => 'Transaction sent';

  @override
  double get width => 420;

  @override
  State<StatefulWidget> createState() => _SendTransactionDialog();
}

class _SendTransactionDialog extends State<SendTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48),
        const SizedBox(
          width: 90,
          height: 90,
          child: Icon(
            Icons.done,
            size: 90,
            color: Color(0xff59b987),
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
    );
  }
}
