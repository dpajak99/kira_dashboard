import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class BalancesListState extends PageState {
  final int pageSize = 10;
  final List<Coin> balances;

  const BalancesListState({
    this.balances = const <Coin>[],
    required super.isLoading,
  });

  BalancesListState copyWith({
    bool? isLoading,
    List<Coin>? balances,
  }) {
    return BalancesListState(
      isLoading: isLoading ?? this.isLoading,
      balances: balances ?? this.balances,
    );
  }

  @override
  List<Object?> get props => [balances, isLoading];
}
