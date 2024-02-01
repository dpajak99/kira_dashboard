import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/send_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/address_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_loading.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class SendTokensDialog extends DialogContentWidget {
  final Coin? initialCoin;

  const SendTokensDialog({
    this.initialCoin,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SendTokensDialogState();
}

class _SendTokensDialogState extends State<SendTokensDialog> {
  late final SendTokensDialogCubit cubit = SendTokensDialogCubit(initialCoin: widget.initialCoin);
  final TextEditingController toAddressController = TextEditingController();
  final TokenAmountTextFieldController tokenAmountTextFieldController = TokenAmountTextFieldController();
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _validateForm();
    tokenAmountTextFieldController.addListener(_validateForm);
    toAddressController.addListener(_validateForm);
  }

  @override
  void dispose() {
    cubit.close();
    toAddressController.dispose();
    tokenAmountTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Send tokens',
      width: 420,
      child: BlocBuilder<SendTokensDialogCubit, SendTokensDialogState>(
        bloc: cubit,
        builder: (BuildContext context, SendTokensDialogState state) {
          return SizedBox(
            child: Column(
              children: [
                AddressTextField(
                  title: 'Receiver address',
                  controller: toAddressController,
                ),
                const SizedBox(height: 16),
                if (state is SendTokensDialogLoadedState)
                  TokenAmountTextField(
                    controller: tokenAmountTextFieldController,
                    address: state.address,
                    initialCoin: state.initialCoin,
                  )
                else
                  const TokenAmountTextFieldLoading(),
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
                    if (state is SendTokensDialogLoadedState)
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
                const SizedBox(height: 64),
                ValueListenableBuilder<String?>(
                  valueListenable: errorNotifier,
                  builder: (BuildContext context, String? error, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: error == null ? () {
                          cubit.sendTransaction(
                            toAddress: toAddressController.text,
                            amounts: [tokenAmountTextFieldController.value!],
                          );
                        } : null,
                        child: Text(error ?? 'Send'),
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
    if (toAddressController.text.isEmpty) {
      errorNotifier.value = 'Enter address';
    } else if (tokenAmountTextFieldController.value == null) {
      errorNotifier.value = 'Enter value';
    } else {
      errorNotifier.value = null;
    }
  }
}
