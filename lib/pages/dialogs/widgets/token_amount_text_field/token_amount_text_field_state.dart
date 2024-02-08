import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

class TokenAmountTextFieldState extends Equatable {
  final Coin selectedTokenAmount;
  final Coin maxTokenAmount;

  const TokenAmountTextFieldState({
    required this.selectedTokenAmount,
    required this.maxTokenAmount,
  });

  TokenAmountTextFieldState.fromBalance(Coin balance) :
        selectedTokenAmount= balance.copyWith(networkAmount: Decimal.parse('0')),
        maxTokenAmount = balance;

  @override
  List<Object?> get props => <Object>[selectedTokenAmount, maxTokenAmount];
}
