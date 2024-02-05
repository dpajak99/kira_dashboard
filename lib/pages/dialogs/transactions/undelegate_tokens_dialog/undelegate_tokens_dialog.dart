import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/undelegate_tokens_dialog/undelegate_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/address_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_loading.dart';
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
  late final UndelegateTokensDialogCubit cubit = UndelegateTokensDialogCubit(validatorAddress: widget.valoperAddress);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  List<TokenAmountTextFieldController> undelegations = [
    TokenAmountTextFieldController(),
  ];

  @override
  void initState() {
    super.initState();
    _validateForm();
    undelegations.first.addListener(_validateForm);
  }

  @override
  void dispose() {
    cubit.close();
    for (TokenAmountTextFieldController controller in undelegations) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Undelegate tokens',
      width: 420,
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
                for (int i = 0; i < undelegations.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TokenAmountTextField(
                      onClose: undelegations.length > 1 ? () => _removeUndelegation(undelegations[i]) : null,
                      controller: undelegations[i],
                      address: state.address,
                      initialCoin: state.initialCoin,
                    ),
                  ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: _addUndelegation,
                    label: Text(
                      'Add undelegation',
                      style: textTheme.bodyMedium,
                    ),
                    icon: const Icon(Icons.add, size: 14),
                  ),
                ),
              ] else ...<Widget>[
                const SizedBox(height: 16),
                const TokenAmountTextFieldLoading(),
              ],
              const SizedBox(height: 8),
              const Divider(color: Color(0xff222b3a)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Fee:',
                    style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                  ),
                  const Spacer(),
                  if (state is UndelegateTokensDialogLoadedState)
                    Text(
                      state.executionFee.toNetworkDenominationString(),
                      style: textTheme.bodyMedium!.copyWith(color:  const Color(0xff6c86ad)),
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
                                amounts: undelegations.map((e) => e.value!).toList(),
                              );
                            }
                          : null,
                      child: Text(error ?? 'Undelegate'),
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

  void _addUndelegation() {
    setState(() {
      TokenAmountTextFieldController controller = TokenAmountTextFieldController();
      controller.addListener(_validateForm);
      undelegations.add(controller);
      _validateForm();
    });
  }

  void _removeUndelegation(TokenAmountTextFieldController controller) {
    setState(() {
      controller.dispose();
      undelegations.remove(controller);
      _validateForm();
    });
  }

  void _validateForm() {
    bool undelegationsValid = true;

    for (TokenAmountTextFieldController controller in undelegations) {
      if (controller.value == null) {
        undelegationsValid = false;
        break;
      }
    }

    if (undelegationsValid) {
      errorNotifier.value = null;
    } else {
      errorNotifier.value = 'Enter amount';
    }
  }
}
