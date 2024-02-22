import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field_state.dart';
import 'package:kira_dashboard/widgets/typeahead_text_field.dart';

class MnemonicTextField extends StatefulWidget {
  final int index;
  final TextEditingController controller;
  final Function(int index, String value) pasteCallback;
  final VoidCallback onChanged;

  const MnemonicTextField({
    super.key,
    required this.index,
    required this.controller,
    required this.pasteCallback,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _MnemonicTextFieldState();
}

class _MnemonicTextFieldState extends State<MnemonicTextField> {
  late final MnemonicTextFieldCubit _cubit = MnemonicTextFieldCubit();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextfieldChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextfieldChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.container,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          BlocBuilder<MnemonicTextFieldCubit, MnemonicTextFieldState>(
            bloc: _cubit,
            builder: (BuildContext context, MnemonicTextFieldState state) {
              Color color;
              if (state.word.isEmpty) {
                color = CustomColors.secondary;
              } else if ((state.hasHint && focusNode.hasFocus) || state.valid) {
                color = CustomColors.green;
              } else {
                color = CustomColors.red;
              }

              return SizedBox(
                width: 24,
                child: Text(
                  '${widget.index}.',
                  style: textTheme.bodyMedium!.copyWith(color: color),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TypeaheadTextField(
              controller: widget.controller,
              focusNode: focusNode,
              style: textTheme.bodyMedium!.copyWith(
                color: CustomColors.white,
                letterSpacing: 1,
              ),
              inputFormatters: [
                PasteInterceptor(
                  focusNode: focusNode,
                  pasteCallback: (String value) => widget.pasteCallback(widget.index - 1, value),
                ),
                LengthLimitingTextInputFormatter(8),
              ],
              suggestionColor: CustomColors.secondary,
              suggestionList: Bip39Languages.english.wordList,
            ),
          ),
        ],
      ),
    );
  }

  void _handleTextfieldChange() {
    widget.onChanged();
    _cubit.setWord(widget.controller.text);
  }
}

class PasteInterceptor extends TextInputFormatter {
  final ValueChanged<String> pasteCallback;
  final FocusNode focusNode;

  PasteInterceptor({
    required this.pasteCallback,
    required this.focusNode,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    bool textPasted = newValue.text.length - oldValue.text.length > 1;
    String value = newValue.text.split(' ').firstOrNull ?? '';
    if (textPasted && value.isNotEmpty) {
      pasteCallback(newValue.text);
      focusNode.unfocus();
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(offset: value.length),
      );
    } else {
      return newValue;
    }
  }
}
