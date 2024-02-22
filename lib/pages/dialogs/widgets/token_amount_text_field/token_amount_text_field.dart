import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/select_token_dialog/select_token_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_layout.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_state.dart';
import 'package:kira_dashboard/pages/dialogs/widgets/token_amount_text_field/token_amount_text_field_cubit.dart';
import 'package:kira_dashboard/widgets/token_icon.dart';

class TokenAmountTextFieldController extends ValueNotifier<Coin?> {
  TokenAmountTextFieldController() : super(null);
}

class TokenAmountTextField extends StatefulWidget {
  final TokenAmountTextFieldController controller;
  final String address;
  final Coin initialCoin;
  final VoidCallback? onClose;

  TokenAmountTextField({
    required this.address,
    required this.initialCoin,
    this.onClose,
    TokenAmountTextFieldController? controller,
    super.key,
  }) : controller = controller ?? TokenAmountTextFieldController();

  @override
  State<StatefulWidget> createState() => _TokenAmountTextFieldState();
}

class _TokenAmountTextFieldState extends State<TokenAmountTextField> {
  late final TokenAmountTextFieldCubit cubit = TokenAmountTextFieldCubit.fromBalance(widget.address, widget.initialCoin);
  final TextEditingController amountTextController = TextEditingController();
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    amountTextController.addListener(_validateBalanceText);
  }

  @override
  void dispose() {
    amountTextController.dispose();
    errorNotifier.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TokenAmountTextFieldCubit, TokenAmountTextFieldState>(
      bloc: cubit,
      builder: (BuildContext context, TokenAmountTextFieldState state) {
        return TokenAmountTextFieldLayout(
          balanceWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Balance: ${state.maxTokenAmount.networkDenominationAmount}',
                style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () => amountTextController.text = state.maxTokenAmount.networkDenominationAmount.toString(),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  color: appColors.primary.withOpacity(0.2),
                  child: Text(
                    'MAX',
                    style: textTheme.labelSmall!.copyWith(height: 1, color: appColors.primary),
                  ),
                ),
              ),
              if (widget.onClose != null) ...<Widget>[
                const SizedBox(width: 8),
                InkWell(
                  onTap: widget.onClose,
                  child: Icon(Icons.close, size: 14, color: appColors.secondary),
                ),
              ]
            ],
          ),
          tokenWidget: Row(
            children: [
              InkWell(
                onTap: selectToken,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TokenIcon(
                        size: 24,
                        iconUrl: state.selectedTokenAmount.icon,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        state.selectedTokenAmount.symbol,
                        style: textTheme.bodyLarge!.copyWith(color: appColors.onBackground),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.expand_more_outlined,
                        color: appColors.secondary,
                        size: 17,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          amountWidget: TextField(
            controller: amountTextController,
            textAlign: TextAlign.right,
            style: textTheme.bodyLarge!.copyWith(color: appColors.onBackground),
            cursorColor: appColors.onBackground,
            cursorWidth: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [
              if (state.selectedTokenAmount.decimals > 0)
                CustomFilteringTextInputFormatter(RegExp(r'^\d*\.?\d{0,' + state.selectedTokenAmount.decimals.toString() + r'}$'))
              else
                FilteringTextInputFormatter.allow(RegExp(r'\d')),
            ],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
            ),
          ),
          footerWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                state.selectedTokenAmount.name,
                style: textTheme.labelLarge!.copyWith(color: appColors.secondary),
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: errorNotifier,
                builder: (BuildContext context, String? errorMessage, _) {
                  if (errorMessage != null) {
                    return Text(
                      errorMessage,
                      style: textTheme.labelLarge!.copyWith(color: appColors.error),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> selectToken() async {
    Coin? coin = await DialogRouter().navigate<Coin?>(SelectTokenDialog(address: widget.address));
    if (coin != null) {
      cubit.selectToken(coin);
      amountTextController.text = '';
    }
  }

  void _validateBalanceText() {
    if (amountTextController.text.isEmpty) {
      widget.controller.value = null;
      errorNotifier.value = null;
      return;
    }
    Decimal selectedAmount = Decimal.parse(amountTextController.text);
    if (selectedAmount > cubit.state.maxTokenAmount.amount) {
      widget.controller.value = null;
      errorNotifier.value = 'Insufficient balance';
    } else {
      widget.controller.value = cubit.state.selectedTokenAmount.copyWith(networkAmount: selectedAmount);
      errorNotifier.value = null;
    }
  }
}

class CustomFilteringTextInputFormatter extends TextInputFormatter {
  final RegExp regExp;

  CustomFilteringTextInputFormatter(this.regExp);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (regExp.hasMatch(newValue.text)) {
      return newValue;
    }

    if (regExp.hasMatch(newValue.text.substring(0, newValue.text.length - 1))) {
      return TextEditingValue(
        text: newValue.text.substring(0, newValue.text.length - 1),
        selection: TextSelection.collapsed(offset: newValue.text.length - 1),
      );
    }

    return oldValue;
  }
}
