import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/transaction_result_dialog/transaction_result_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/token_amount_text_field/token_amount_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/send_tokens_dialog/token_amount_text_field/token_amount_text_field_loading.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/address_text_field.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class UndelegateTokensDialog extends DialogContentWidget {
  final String valoperAddress;

  const UndelegateTokensDialog({
    required this.valoperAddress,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _UndelegateTokensDialogState();
}

class _UndelegateTokensDialogState extends State<UndelegateTokensDialog> {
  late final UndelegateTokensDialogCubit cubit = UndelegateTokensDialogCubit();
  List<TokenAmountTextFieldController> delegations = [
    TokenAmountTextFieldController(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Undelegate tokens',
      width: 420,
      scrollable: true,
      child: BlocBuilder<UndelegateTokensDialogCubit, UndelegateTokensDialogState>(
        bloc: cubit,
        builder: (BuildContext context, UndelegateTokensDialogState state) {
          return Column(
            children: [
              AddressTextField(
                title: 'Validator address',
                locked: true,
                controller: TextEditingController(text: widget.valoperAddress),
              ),
              if (state is UndelegateTokensDialogLoadedState) ...<Widget>[
                for (int i = 0; i < delegations.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TokenAmountTextField(
                      controller: delegations[i],
                      address: state.address,
                      initialCoin: state.initialCoin,
                    ),
                  ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      setState(() {
                        delegations.add(TokenAmountTextFieldController());
                      });
                    },
                    label: const Text('Add undelegation', style: TextStyle(fontSize: 14)),
                    icon: const Icon(Icons.add, size: 14),
                  ),
                ),
              ] else ...<Widget>[
                const SizedBox(height: 16),
                const TokenAmountTextFieldLoading(),
              ],
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
                  if (state is UndelegateTokensDialogLoadedState)
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
                  onPressed: () => showDialog(context: context, builder: (BuildContext context) => const CustomDialogRoute(content: TransactionResultDialog())),
                  child: const Text('Undelegate'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
