import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field_state.dart';
import 'package:kira_dashboard/widgets/typeahead_text_field.dart';

class MnemonicTextField extends StatefulWidget {
  final int index;
  final String? word;
  final ValueChanged<String> onConfirmed;

  const MnemonicTextField({
    super.key,
    required this.index,
    required this.word,
    required this.onConfirmed,
  });

  @override
  State<StatefulWidget> createState() => _MnemonicTextFieldState();
}

class _MnemonicTextFieldState extends State<MnemonicTextField> {
  late final MnemonicTextFieldCubit _cubit = MnemonicTextFieldCubit(onConfirmed: widget.onConfirmed);
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff131823),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          BlocBuilder<MnemonicTextFieldCubit, MnemonicTextFieldState>(
            bloc: _cubit,
            builder: (BuildContext context, MnemonicTextFieldState state) {
              Color color = state.valid ? const Color(0xff59b987) : const Color(0xfff12e1f);
              if (state.word.isEmpty) {
                color = const Color(0xff6c86ad);
              }
              return SizedBox(
                width: 24,
                child: Text(
                  '${widget.index}.',
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TypeaheadTextField(
              controller: TextEditingController(),
              focusNode: focusNode,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xfffbfbfb),
                letterSpacing: 1,
              ),
              onChanged: _cubit.setWord,
              suggestionColor: const Color(0xff6c86ad),
              suggestionList: Bip39Languages.english.wordList,
            ),
          ),
        ],
      ),
    );
  }
}
