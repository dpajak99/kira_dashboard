import 'package:equatable/equatable.dart';

class SignInMnemonicDialogState extends Equatable {
  final int wordsCount;
  Map<int, String?> words = <int, String?>{};

  SignInMnemonicDialogState({
    required this.wordsCount,
    required this.words,
  });

  SignInMnemonicDialogState copyWith({
    int? wordsCount,
    Map<int, String?>? words,
  }) {
    return SignInMnemonicDialogState(
      wordsCount: wordsCount ?? this.wordsCount,
      words: words ?? this.words,
    );
  }

  @override
  List<Object?> get props => <Object?>[wordsCount, words];
}
