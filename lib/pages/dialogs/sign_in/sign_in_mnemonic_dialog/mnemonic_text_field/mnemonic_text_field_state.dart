import 'package:equatable/equatable.dart';

class MnemonicTextFieldState extends Equatable {
  final bool valid;
  final String word;
  final bool hasHint;

  const MnemonicTextFieldState({
    required this.valid,
    required this.word,
    required this.hasHint,
  });

  @override
  List<Object?> get props => <Object?>[valid, word, hasHint];
}