import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

class Transaction extends Equatable {
  final DateTime time;
  final String hash;
  final String status;
  final String direction;
  final List<Coin> fee;
  final List<Coin> amounts;
  final String? from;
  final String? to;
  final String method;

  const Transaction({
    required this.time,
    required this.hash,
    required this.status,
    required this.direction,
    required this.fee,
    required this.amounts,
    required this.method,
    this.from,
    this.to,
  });

  @override
  List<Object?> get props => <Object?>[time, hash, status, direction, fee, amounts, from, to, method];
}