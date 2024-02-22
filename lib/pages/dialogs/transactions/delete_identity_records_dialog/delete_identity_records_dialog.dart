import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delete_identity_records_dialog/delete_identity_records_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/identity_records_picker/identity_records_picker.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class DeleteIdentityRecordsDialog extends DialogContentWidget {
  final List<IdentityRecord> records;

  const DeleteIdentityRecordsDialog({
    required this.records,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DeleteIdentityRecordsDialogState();
}

class _DeleteIdentityRecordsDialogState extends State<DeleteIdentityRecordsDialog> {
  late final DeleteIdentityRecordsDialogCubit cubit = DeleteIdentityRecordsDialogCubit();
  final IdentityRecordsPickerController identityRecordsPickerController = IdentityRecordsPickerController();
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _validateForm();
    identityRecordsPickerController.addListener(_validateForm);
  }

  @override
  void dispose() {
    cubit.close();
    identityRecordsPickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Delete records',
      width: 420,
      child: BlocBuilder<DeleteIdentityRecordsDialogCubit, DeleteIdentityRecordsDialogState>(
        bloc: cubit,
        builder: (BuildContext context, DeleteIdentityRecordsDialogState state) {
          return SizedBox(
            child: Column(
              children: [
                IdentityRecordsPicker(
                  controller: identityRecordsPickerController,
                  address: state.address,
                  initialRecords: widget.records,
                ),
                const SizedBox(height: 8),
                Divider(color: CustomColors.divider),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Fee:',
                      style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                    ),
                    const Spacer(),
                    if (state is DeleteIdentityRecordsDialogLoadedState)
                      Text(
                        state.executionFee.toNetworkDenominationString(),
                        style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
                      )
                    else
                      const SizedShimmer(width: 60, height: 14, reversed: true),
                  ],
                ),
                const SizedBox(height: 64),
                ValueListenableBuilder<String?>(
                  valueListenable: errorNotifier,
                  builder: (BuildContext context, String? error, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: error == null
                            ? () {
                                cubit.sendTransaction(
                                  keys: identityRecordsPickerController.value.map((e) => e.key).toList(),
                                );
                              }
                            : null,
                        child: Text(error ?? 'Delete records'),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _validateForm() {
    if (identityRecordsPickerController.value.isEmpty) {
      errorNotifier.value = 'Select records';
    } else {
      errorNotifier.value = null;
    }
  }
}
