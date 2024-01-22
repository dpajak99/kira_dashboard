import 'package:bech32/bech32.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/send_tokens_dialog/send_tokens_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/send_tokens_dialog/send_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/send_tokens_dialog/token_amount_text_field/token_amount_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/send_tokens_dialog/token_amount_text_field/token_amount_text_field_loading.dart';
import 'package:kira_dashboard/pages/dialogs/send_transaction_dialog/send_transaction_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/address_text_field.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
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

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Send tokens',
      width: 420,
      scrollable: false,
      child: BlocBuilder<SendTokensDialogCubit, SendTokensDialogState>(
        bloc: cubit,
        builder: (BuildContext context, SendTokensDialogState state) {
          return SizedBox(
            child: Column(
              children: [
                AddressTextField(
                  title: 'Receiver address',
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 16),
                if (state is SendTokensDialogLoadedState)
                  TokenAmountTextField(
                    address: state.address,
                    initialCoin: state.initialCoin,
                  )
                else
                  const TokenAmountTextFieldLoading(),
                const SizedBox(height: 16),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => showDialog(context: context, builder: (BuildContext context) => const CustomDialogRoute(content: SendTransactionDialog())),
                    child: const Text('Send'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
