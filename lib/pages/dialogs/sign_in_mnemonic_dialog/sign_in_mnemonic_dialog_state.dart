import 'package:equatable/equatable.dart';

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
