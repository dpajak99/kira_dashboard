import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/verify_identity_records_dialog/verify_identity_records_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/address_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/identity_records_picker/identity_records_picker.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_loading.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class VerifyIdentityRecordsDialog extends DialogContentWidget {
  final List<IdentityRecord> records;

  const VerifyIdentityRecordsDialog({
    required this.records,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _VerifyIdentityRecordsDialogState();
}

class _VerifyIdentityRecordsDialogState extends State<VerifyIdentityRecordsDialog> {
  late final VerifyIdentityRecordsDialogCubit cubit = VerifyIdentityRecordsDialogCubit();
  final IdentityRecordsPickerController identityRecordsPickerController = IdentityRecordsPickerController();
  final TextEditingController verifierAddressController = TextEditingController();
  final TokenAmountTextFieldController tokenAmountTextFieldController = TokenAmountTextFieldController();
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _validateForm();
    identityRecordsPickerController.addListener(_validateForm);
    tokenAmountTextFieldController.addListener(_validateForm);
    verifierAddressController.addListener(_validateForm);
  }

  @override
  void dispose() {
    cubit.close();
    identityRecordsPickerController.dispose();
    verifierAddressController.dispose();
    tokenAmountTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Request verification',
      width: 420,
      child: BlocBuilder<VerifyIdentityRecordsDialogCubit, VerifyIdentityRecordsDialogState>(
        bloc: cubit,
        builder: (BuildContext context, VerifyIdentityRecordsDialogState state) {
          return SizedBox(
            child: Column(
              children: [
                IdentityRecordsPicker(
                  controller: identityRecordsPickerController,
                  address: state.address,
                  initialRecords: widget.records,
                ),
                const SizedBox(height: 16),
                AddressTextField(
                  title: 'Verifier address',
                  controller: verifierAddressController,
                ),
                const SizedBox(height: 16),
                if (state is VerifyIdentityRecordsDialogLoadedState)
                  TokenAmountTextField(
                    controller: tokenAmountTextFieldController,
                    address: state.address,
                    initialCoin: state.initialCoin,
                  )
                else
                  const TokenAmountTextFieldLoading(),
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
                    if (state is VerifyIdentityRecordsDialogLoadedState)
                      Text(
                        state.executionFee.toNetworkDenominationString(),
                        style: textTheme.bodyMedium!.copyWith(color:  CustomColors.secondary),
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
                                  toAddress: verifierAddressController.text,
                                  tip: tokenAmountTextFieldController.value!,
                                  recordIds: identityRecordsPickerController.value.map((e) => e.id).toList(),
                                );
                              }
                            : null,
                        child: Text(error ?? 'Request verification'),
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
    } else if (verifierAddressController.text.isEmpty) {
      errorNotifier.value = 'Enter address';
    } else if (tokenAmountTextFieldController.value == null) {
      errorNotifier.value = 'Enter value';
    } else {
      errorNotifier.value = null;
    }
  }
}
