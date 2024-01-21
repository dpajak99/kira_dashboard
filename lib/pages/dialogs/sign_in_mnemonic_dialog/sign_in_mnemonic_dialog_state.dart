import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SignInMnemonicDialogState extends Equatable {
  final int wordsCount;
  final bool valid;

  const SignInMnemonicDialogState({required this.wordsCount, required this.valid});

  SignInMnemonicDialogState copyWith({
    int? wordsCount,
    bool? valid,
  }) {
    return SignInMnemonicDialogState(
      wordsCount: wordsCount ?? this.wordsCount,
      valid: valid ?? this.valid,
    );
  }

  @override
  List<Object?> get props => <Object?>[wordsCount, valid];
}
