import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/identity_record_input.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class EditRecordDialog extends DialogContentWidget {
  final IdentityRecordInputController controller;
  final int? maxLength;

  const EditRecordDialog({
    required this.controller,
    this.maxLength,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _EditRecordDialogState();
}

class _EditRecordDialogState extends State<EditRecordDialog> {
  late final IdentityRecordInputController controller = IdentityRecordInputController.copy(widget.controller);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Edit record',
      width: 420,
      scrollable: false,
      child: Column(
        children: [
          IdentityRecordInput(
            controller: controller,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: lightElevatedButton,
                  onPressed: () {
                    CustomDialogRoute.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: darkElevatedButton,
                  onPressed: () {
                    widget.controller.value = controller.value;
                    CustomDialogRoute.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
