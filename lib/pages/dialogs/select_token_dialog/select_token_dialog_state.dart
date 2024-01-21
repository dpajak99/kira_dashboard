import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

class SelectTokenDialogState extends Equatable {
  final List<Coin> balances;

  const SelectTokenDialogState({
    required this.balances,
  });

  @override
  List<Object?> get props => [balances];
}
