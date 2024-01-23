import 'package:blockchain_utils/bip/bip/bip39/bip39_mnemonic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field_state.dart';

class MnemonicTextFieldCubit extends Cubit<MnemonicTextFieldState> {
  MnemonicTextFieldCubit() : super(const MnemonicTextFieldState(valid: false, word: '', hasHint: false));

  void setWord(String word) {
    bool wordValid = Bip39Languages.english.wordList.contains(word);
    bool hasHint = Bip39Languages.english.wordList.where((e) => e.startsWith(word)).isNotEmpty;
    emit(MnemonicTextFieldState(valid: wordValid, word: word, hasHint: hasHint));
  }
}
