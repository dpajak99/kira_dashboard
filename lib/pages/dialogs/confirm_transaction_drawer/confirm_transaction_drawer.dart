import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Confirm transaction',
      width: 420,
      child: Column(
        children: [
          const SizedBox(height: 48),
          SizedBox(
            width: 90,
            height: 90,
            child: CircularProgressIndicator(color: appColors.primary, strokeWidth: 2),
          ),
          const SizedBox(height: 48),
          Text(
            'Please, confirm transaction in your wallet',
            style: textTheme.titleLarge!.copyWith(color: appColors.secondary),
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
