import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/error_explorer_dialog/error_explorer_dialog.dart';
import 'package:kira_dashboard/utils/exceptions/internal_broadcast_exception.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

enum TransactionProcessStatus {
  broadcast,
  success,
  failed,
}

class TransactionResultDialog extends DialogContentWidget {
  final TransactionProcessStatus status;
  final String? hash;
  final InternalBroadcastException? internalBroadcastException;

  const TransactionResultDialog({
    super.key,
    this.status = TransactionProcessStatus.broadcast,
    this.hash,
    this.internalBroadcastException,
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
          if(widget.internalBroadcastException != null) ...<Widget>[
            Text(
              widget.internalBroadcastException!.code,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xffe74c3c),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.internalBroadcastException!.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff6c86ad),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: darkElevatedButton,
                onPressed: () => DialogRouter().navigate(ErrorExplorerDialog(response: widget.internalBroadcastException!.response)),
                child: const Text('See details'),
              ),
            ),
            const SizedBox(height: 16),
          ],

          if( widget.hash != null ) ...<Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: darkElevatedButton,
                onPressed: () {
                  Navigator.of(context).pop();
                  AutoRouter.of(context).navigate(TransactionDetailsRoute(hash: widget.hash!));
                },
                child: const Text('Show'),
              ),
            ),
            const SizedBox(height: 16),
          ],
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
