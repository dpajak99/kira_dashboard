import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field_state.dart';

class MnemonicTextFieldCubit extends Cubit<MnemonicTextFieldState> {
  final ValueChanged<String> onConfirmed;

  MnemonicTextFieldCubit({
    required this.onConfirmed,
  }) : super(const MnemonicTextFieldState(valid: false, word: ''));

  void setWord(String word, String hint) {
    bool wordValid = hint.isNotEmpty && word.isNotEmpty;
    emit(MnemonicTextFieldState(valid: wordValid, word: word));

    if(wordValid) {
      onConfirmed(word);
    }
  }
}
