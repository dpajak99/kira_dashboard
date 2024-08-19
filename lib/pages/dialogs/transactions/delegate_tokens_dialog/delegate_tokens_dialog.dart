import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/transactions/delegate_tokens_dialog/delegate_tokens_dialog_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/address_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_loading.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class DelegateTokensDialog extends DialogContentWidget {
  final String valoperAddress;

  const DelegateTokensDialog({
    required this.valoperAddress,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DelegateTokensDialogState();
}

class _DelegateTokensDialogState extends State<DelegateTokensDialog> {
  late final DelegateTokensDialogCubit cubit = DelegateTokensDialogCubit(validatorAddress: widget.valoperAddress);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  List<TokenAmountTextFieldController> delegations = [
    TokenAmountTextFieldController(),
  ];

  @override
  void initState() {
    super.initState();
    _validateForm();
    delegations.first.addListener(_validateForm);
  }

  @override
  void dispose() {
    cubit.close();
    for (TokenAmountTextFieldController controller in delegations) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Delegate tokens',
      width: 420,
      child: BlocBuilder<DelegateTokensDialogCubit, DelegateTokensDialogState>(
        bloc: cubit,
        builder: (BuildContext context, DelegateTokensDialogState state) {
          return Column(
            children: [
              AddressTextField(
                title: 'Validator address',
                locked: true,
                controller: TextEditingController(text: widget.valoperAddress),
              ),
              if (state is DelegateTokensDialogLoadedState) ...<Widget>[
                for (int i = 0; i < delegations.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TokenAmountTextField(
                      onClose: delegations.length > 1 ? () => _removeDelegation(delegations[i]) : null,
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
                    onPressed: _addDelegation,
                    label: Text(
                      'Add delegation',
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
              const Divider(color: CustomColors.divider),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Fee:',
                    style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                  ),
                  const Spacer(),
                  if (state is DelegateTokensDialogLoadedState)
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
                                amounts: delegations.map((e) => e.value!).toList(),
                              );
                            }
                          : null,
                      child: Text(error ?? 'Delegate'),
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

  void _addDelegation() {
    setState(() {
      TokenAmountTextFieldController controller = TokenAmountTextFieldController();
      controller.addListener(_validateForm);
      delegations.add(controller);
      _validateForm();
    });
  }

  void _removeDelegation(TokenAmountTextFieldController controller) {
    setState(() {
      controller.dispose();
      delegations.remove(controller);
      _validateForm();
    });
  }

  void _validateForm() {
    bool delegationsValid = true;

    for (TokenAmountTextFieldController controller in delegations) {
      if (controller.value == null) {
        delegationsValid = false;
        break;
      }
    }

    if (delegationsValid) {
      errorNotifier.value = null;
    } else {
      errorNotifier.value = 'Enter amount';
    }
  }
}
