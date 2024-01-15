import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  final String amount;
  final String denom;

  const CoinEntity({
    required this.amount,
    required this.denom,
  });

  factory CoinEntity.fromJson(Map<String, dynamic> json) {
    return CoinEntity(
      amount: json['amount'] as String,
      denom: json['denom'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[amount, denom];
}
