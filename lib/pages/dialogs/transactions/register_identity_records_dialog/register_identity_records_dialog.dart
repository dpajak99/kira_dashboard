import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/send_transaction_dialog/send_transaction_dialog.dart';
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

  late List<IdentityRecordInputController> controllers = [
    if (widget.records.isEmpty) IdentityRecordInputController(),
    for (IdentityRecord record in widget.records) IdentityRecordInputController.fromValue(IdentityRecordInputModel.fromValues(
      key: record.key,
      value: record.value,
    )),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: switch (widget.records.length) {
        0 => 'Register record',
        1 => 'Edit record',
        (_) => 'Edit records',
      },
      width: 420,
      scrollable: true,
      child: BlocBuilder<RegisterIdentityRecordsDialogCubit, RegisterIdentityRecordsDialogState>(
        bloc: cubit,
        builder: (BuildContext context, RegisterIdentityRecordsDialogState state) {
          return Column(
            children: [
              if (controllers.length == 1)
                IdentityRecordInput(
                  controller: controllers.first,
                )
              else
                for (IdentityRecordInputController controller in controllers)
                  _RecordPreview(
                    controller: controller,
                    onDelete: () => setState(() {
                      controllers.remove(controller);
                    }),
                    onEdit: () => CustomDialogRoute.of(context).navigate(EditRecordDialog(controller: controller)),
                  ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    setState(() {
                      controllers.add(IdentityRecordInputController());
                    });
                  },
                  label: const Text('Add record', style: TextStyle(fontSize: 14)),
                  icon: const Icon(Icons.add, size: 14),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(color: Color(0xff222b3a)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    'Fee:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xfffbfbfb),
                    ),
                  ),
                  const Spacer(),
                  if (state is RegisterIdentityRecordsDialogLoadedState)
                    Text(
                      state.executionFee.toNetworkDenominationString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff6c86ad),
                      ),
                    )
                  else
                    const SizedShimmer(width: 60, height: 14, reversed: true),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => showDialog(context: context, builder: (BuildContext context) => const CustomDialogRoute(content: SendTransactionDialog())),
                  child: const Text('Delegate'),
                ),
              ),
            ],
          );
        },
      ),
    );
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
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (BuildContext context, IdentityRecordInputModel record, _) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xff06070a),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key',
                      style: TextStyle(fontSize: 13, color: Color(0xff6c86ad)),
                    ),
                    Text(
                      controller.hasKey ? controller.irKey : '---',
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
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
                    const Text(
                      'Value',
                      style: TextStyle(fontSize: 13, color: Color(0xff6c86ad)),
                    ),
                    Text(
                      controller.hasValue ? controller.irValue : '---',
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14, color: Color(0xfffbfbfb)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(AppIcons.pencil, color: Color(0xff6c86ad), size: 20),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.close, color: Color(0xff6c86ad), size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
