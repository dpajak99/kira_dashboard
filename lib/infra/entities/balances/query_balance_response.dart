import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';

class QueryBalanceResponse extends Equatable {
  final List<CoinEntity> balances;
  final Pagination? pagination;

  const QueryBalanceResponse({
    required this.balances,
    required this.pagination,
  });

  factory QueryBalanceResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> balancesList = json['balances'] != null ? json['balances'] as List<dynamic> : List<dynamic>.empty();

    return QueryBalanceResponse(
      balances: balancesList.map((dynamic e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList(),
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>) : null,
    );
  }

  @override
  List<Object?> get props => <Object?>[balances];
}

class Pagination extends Equatable {
  final int total;

  Pagination.fromJson(Map<String, dynamic> json) : total = int.parse(json['total']);

  @override
  List<Object?> get props => <Object>[total];
}
