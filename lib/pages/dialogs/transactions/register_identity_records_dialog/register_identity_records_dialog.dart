import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/infra/entities/transactions/methods/governance.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/edit_record_dialog/edit_record_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/register_identity_records_dialog/register_identity_records_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/identity_record_input.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class RegisterIdentityRecordsDialog extends DialogContentWidget {
  final List<IdentityRecord> records;

  const RegisterIdentityRecordsDialog({
    this.records = const [],
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RegisterIdentityRecordsDialogState();
}

class _RegisterIdentityRecordsDialogState extends State<RegisterIdentityRecordsDialog> {
  late final RegisterIdentityRecordsDialogCubit cubit = RegisterIdentityRecordsDialogCubit();
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  late List<IdentityRecordInputController> controllers = [
    if (widget.records.isEmpty) IdentityRecordInputController(),
    for (IdentityRecord record in widget.records)
      IdentityRecordInputController.fromValue(IdentityRecordInputModel.fromValues(
        key: record.key,
        value: record.value,
      )),
  ];

  @override
  void initState() {
    super.initState();
    _validateForm();
    for (IdentityRecordInputController controller in controllers) {
      controller.addListener(_validateForm);
    }
  }

  @override
  void dispose() {
    cubit.close();
    for (IdentityRecordInputController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: switch (widget.records.length) {
        0 => 'Register record',
        1 => 'Edit record',
        (_) => 'Edit records',
      },
      width: 420,
      child: BlocBuilder<RegisterIdentityRecordsDialogCubit, RegisterIdentityRecordsDialogState>(
        bloc: cubit,
        builder: (BuildContext context, RegisterIdentityRecordsDialogState state) {
          return Column(
            children: [
              if (controllers.length == 1)
                IdentityRecordInput(controller: controllers.first)
              else
                for (IdentityRecordInputController controller in controllers)
                  _RecordPreview(
                    controller: controller,
                    onDelete: () => _removeRecord(controller),
                    onEdit: () => DialogRouter().navigate(EditRecordDialog(controller: controller)),
                  ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: _addRecord,
                  label: Text('Add record', style: textTheme.bodyMedium),
                  icon: const Icon(Icons.add, size: 14),
                ),
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
                  if (state is RegisterIdentityRecordsDialogLoadedState)
                    Text(
                      state.executionFee.toNetworkDenominationString(),
                      style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
                    )
                  else
                    const SizedShimmer(width: 60, height: 14, reversed: true),
                ],
              ),
              const SizedBox(height: 32),
              ValueListenableBuilder<String?>(
                valueListenable: errorNotifier,
                builder: (BuildContext context, String? error, _) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: error == null
                          ? () {
                              cubit.sendTransaction(
                                identityInfoEntries: controllers.map((e) => IdentityInfoEntry(key: e.irKey, info: e.irValue)).toList(),
                              );
                            }
                          : null,
                      child: Text(error ?? 'Register'),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _addRecord() {
    setState(() {
      IdentityRecordInputController controller = IdentityRecordInputController();
      controller.addListener(_validateForm);
      controllers.add(controller);
      _validateForm();
    });
  }

  void _removeRecord(IdentityRecordInputController controller) {
    setState(() {
      controller.dispose();
      controllers.remove(controller);
      _validateForm();
    });
  }

  void _validateForm() {
    bool delegationsValid = true;

    for (IdentityRecordInputController controller in controllers) {
      if (controller.isValid == false) {
        delegationsValid = false;
        break;
      }
    }

    if (delegationsValid) {
      errorNotifier.value = null;
    } else {
      errorNotifier.value = 'Enter records';
    }
  }
}

class _RecordPreview extends StatelessWidget {
  final IdentityRecordInputController controller;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const _RecordPreview({
    required this.controller,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, IdentityRecordInputModel record, _) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CustomColors.dialogContainer,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key',
                      style: textTheme.labelLarge!.copyWith(color: CustomColors.secondary),
                    ),
                    Text(
                      controller.hasKey ? controller.irKey : '---',
                      maxLines: 1,
                      style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Value',
                      style: textTheme.labelLarge!.copyWith(color: CustomColors.secondary),
                    ),
                    Text(
                      controller.hasValue ? controller.irValue : '---',
                      maxLines: 1,
                      style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onEdit,
                icon: Icon(AppIcons.pencil, color: CustomColors.secondary, size: 20),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.close, color: CustomColors.secondary, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
