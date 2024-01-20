import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog_state.dart';

class SignInMnemonicDialogCubit extends Cubit<SignInMnemonicDialogState> {
  Map<int, String?> words = <int, String?>{};

  SignInMnemonicDialogCubit() : super(SignInMnemonicDialogState(wordsCount: 24, words: const <int, String?>{}));

  void setWordsCount(int wordsCount) {
    words.clear();
    emit(state.copyWith(words: words, wordsCount: wordsCount));
  }

  void setWord(int index, String word, {bool notify = false}) {
    words[index] = word;
    if (notify) {
      emit(state.copyWith(words: words));
    }
  }
}