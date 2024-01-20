import 'package:equatable/equatable.dart';

class MnemonicTextFieldState extends Equatable {
  final bool valid;
  final String word;

  const MnemonicTextFieldState({
    required this.valid,
    required this.word,
  });

  @override
  List<Object?> get props => <Object?>[valid, word];
}