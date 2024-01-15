import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';

class QueryBalanceResponse extends Equatable {
  final List<CoinEntity> balances;

  const QueryBalanceResponse({
    required this.balances,
  });

  factory QueryBalanceResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> balancesList = json['balances'] != null ? json['balances'] as List<dynamic> : List<dynamic>.empty();

    return QueryBalanceResponse(
      balances: balancesList.map((dynamic e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[balances];
}
