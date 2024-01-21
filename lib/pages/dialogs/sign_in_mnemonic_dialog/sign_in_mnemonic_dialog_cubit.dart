import 'dart:math';

import 'package:blockchain_utils/bip/bip/bip39/bip39_mnemonic_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog_state.dart';

class SignInMnemonicDialogCubit extends Cubit<SignInMnemonicDialogState> {
  Map<int, TextEditingController> wordsControllers = <int, TextEditingController>{};

  SignInMnemonicDialogCubit() : super(const SignInMnemonicDialogState(wordsCount: 24, valid: false));

  void setWordsCount(int wordsCount) {
    int iterationsCount = max(wordsCount, wordsControllers.length);
    for (int i = 0; i < iterationsCount; i++) {
      if( i > wordsCount) {
        wordsControllers.remove(i);
      } else if(wordsControllers[i] == null) {
        wordsControllers[i] = TextEditingController();
      } else {
        wordsControllers[i]?.clear();
      }
    }
    emit(state.copyWith(wordsCount: wordsCount));
  }

  void pasteValue(int index, String value) {
    List<String> pastedWords = value.split(' ');
    for (int i = index; i < index + pastedWords.length; i++) {
      wordsControllers[i]?.text = pastedWords[i - index];
    }
  }

  void validate() {
    bool wasValid = state.valid;
    bool isValid = mnemonicValid;

    if(wasValid != isValid) {
      emit(state.copyWith(valid: isValid));
    }
  }

  List<String> get mnemonicList {
    return wordsControllers.values.map((e) => e.text).toList();
  }

  bool get mnemonicValid {
    List<String> words = wordsControllers.values.map((e) => e.text).toList();
    Bip39MnemonicValidator validator = Bip39MnemonicValidator();
    return validator.isValid(words.join(' '));
  }
}
