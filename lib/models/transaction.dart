import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

class Transaction extends Equatable {
  final DateTime time;
  final String hash;
  final String status;
  final String direction;
  final String memo;
  final List<Coin> fee;
  final List<dynamic> txs;

  const Transaction({
    required this.time,
    required this.hash,
    required this.status,
    required this.direction,
    required this.memo,
    required this.fee,
    required this.txs,
  });

  @override
  List<Object?> get props => <Object?>[time, hash, status, direction, memo, fee, txs];
}