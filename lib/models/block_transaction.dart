import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

class BlockTransaction extends Equatable {
  final DateTime time;
  final String hash;
  final int block;
  final List<Coin> fee;
  final List<Coin> amounts;
  final String? from;
  final String? to;
  final String method;

  const BlockTransaction({
    required this.time,
    required this.hash,
    required this.block,
    required this.fee,
    required this.amounts,
    required this.method,
    this.from,
    this.to,
  });

  @override
  List<Object?> get props => <Object?>[time, hash, fee, amounts, from, to, method];
}