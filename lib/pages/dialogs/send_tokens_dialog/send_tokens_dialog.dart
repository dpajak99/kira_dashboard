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
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';
import 'package:kira_dashboard/widgets/sized_shimmer.dart';

class SendTokensDialog extends DialogContentWidget {
  final Coin? initialCoin;

  const SendTokensDialog({
    this.initialCoin,
    super.key,
  });

  @override
  String get title => 'Send tokens';

  @override
  double get width => 420;

  @override
  State<StatefulWidget> createState() => _SendTokensDialogState();
}

class _SendTokensDialogState extends State<SendTokensDialog> {
  late final SendTokensDialogCubit cubit = SendTokensDialogCubit(initialCoin: widget.initialCoin);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendTokensDialogCubit, SendTokensDialogState>(
      bloc: cubit,
      builder: (BuildContext context, SendTokensDialogState state) {
        return SizedBox(
          height: 350,
          child: Column(
            children: [
              _AddressTextField(
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
              const Spacer(),
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
    );
  }
}

class _AddressTextField extends StatefulWidget {
  final TextEditingController controller;

  const _AddressTextField({
    required this.controller,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<_AddressTextField> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController tmpController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);
  bool addressVisible = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff06070a),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Receiver address',
                style: TextStyle(fontSize: 13, color: Color(0xff6c86ad)),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                radius: 30,
                child: const Icon(
                  Icons.paste,
                  color: Color(0xff6c86ad),
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (addressVisible) ...[
                  Center(
                    child: IdentityAvatar(size: 25, address: tmpController.text),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Center(
                    child: TextField(
                      focusNode: focusNode,
                      controller: controller,
                      style: const TextStyle(fontSize: 20, color: Color(0xfffbfbfb)),
                      cursorColor: const Color(0xfffbfbfb),
                      cursorWidth: 1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'kira...',
                        hintStyle: TextStyle(fontSize: 20, color: Color(0xff3e4c63)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: errorNotifier,
                builder: (BuildContext context, String? errorMessage, _) {
                  if (errorMessage != null) {
                    return Text(
                      errorMessage,
                      style: const TextStyle(fontSize: 13, color: Color(0xfff12e1f)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleFocusChanged() {
    bool addressValid = _validateAddress(tmpController.text);

    if (focusNode.hasFocus == false) {
      tmpController.text = controller.text;
      addressValid = _validateAddress(tmpController.text);

      if (addressValid) {
        controller.text = '${controller.text.substring(0, 10)}...${controller.text.substring(controller.text.length - 5)}';
        errorNotifier.value = null;
      } else {
        errorNotifier.value = 'Invalid address';
      }
    } else {
      controller.text = tmpController.text;
    }
    setState(() {
      addressVisible = !focusNode.hasFocus && addressValid;
    });
  }

  bool _validateAddress(String address) {
    bool addressValid = true;
    try {
      bech32.decode(address);
    } catch (_) {
      addressValid = false;
    }
    return addressValid;
  }
}
