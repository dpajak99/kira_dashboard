import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/select_identity_records_dialog/select_identity_records_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/select_identity_records_dialog/select_identity_records_dialog_state.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class SelectIdentityRecordsDialog extends DialogContentWidget {
  final String address;
  final List<IdentityRecord> selectedRecords;

  const SelectIdentityRecordsDialog({
    super.key,
    required this.address,
    required this.selectedRecords,
  });

  @override
  State<StatefulWidget> createState() => _SelectIdentityRecordsDialogState();
}

class _SelectIdentityRecordsDialogState extends State<SelectIdentityRecordsDialog> {
  late final SelectIdentityRecordsDialogCubit cubit = SelectIdentityRecordsDialogCubit(address: widget.address);
  late final Set<IdentityRecord> selectedRecords = widget.selectedRecords.toSet();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Select Identity Records',
      width: 420,
      contentPadding: EdgeInsets.zero,
      child: BlocBuilder<SelectIdentityRecordsDialogCubit, SelectIdentityRecordsDialogState>(
        bloc: cubit,
        builder: (BuildContext context, SelectIdentityRecordsDialogState state) {
          return Column(
            children: [
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: state.records.length,
                  itemBuilder: (BuildContext context, int index) {
                    IdentityRecord record = state.records[index];
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: selectedRecords.contains(record),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      dense: true,
                      activeColor: appColors.primary,
                      side: BorderSide(color: appColors.primary, width: 2),
                      onChanged: (_) => _toggleRecord(record),
                      title: Text(
                        record.key,
                        maxLines: 1,
                        style: textTheme.bodyMedium!.copyWith( color: appColors.onBackground),
                      ),
                      subtitle: Text(
                        record.value,
                        maxLines: 1,
                        style: textTheme.labelMedium!.copyWith( color: appColors.secondary),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 48),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: darkElevatedButton,
                  onPressed: () => DialogRouter().navigateBack(selectedRecords.toList()),
                  child: const Text('Confirm'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _toggleRecord(IdentityRecord record) {
    setState(() {
      if (selectedRecords.contains(record)) {
        selectedRecords.remove(record);
      } else {
        selectedRecords.add(record);
      }
    });
  }
}
