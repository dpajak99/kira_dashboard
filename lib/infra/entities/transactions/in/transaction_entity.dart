import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class TransactionEntity extends Equatable {
  final int time;
  final String hash;
  final String status;
  final String direction;
  final String memo;
  final List<CoinEntity> fee;
  final List<TxMsg> txs;

  const TransactionEntity({
    required this.time,
    required this.hash,
    required this.status,
    required this.direction,
    required this.memo,
    required this.fee,
    required this.txs,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    List<dynamic> feeList = json['fee'] != null ? json['fee'] as List<dynamic> : List<dynamic>.empty();
    List<dynamic> txsList = json['txs'] != null ? json['txs'] as List<dynamic> : List<dynamic>.empty();

    return TransactionEntity(
      time: json['time'] as int,
      hash: json['hash'] as String,
      status: json['status'] as String,
      direction: json['direction'] as String,
      memo: json['memo'] as String,
      fee: feeList.map((dynamic e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList(),
      txs: txsList.map((dynamic e) => TxMsg.fromJsonByName(e['type'], e)).toList()
    );
  }

  Set<String> get allDenominations {
    List<String> txsDenominations = txs.expand((TxMsg tx) => tx.txAmounts.map((CoinEntity coin) => coin.denom)).toList();
    List<String> feeDenominations = fee.map((CoinEntity coin) => coin.denom).toList();

    return {...txsDenominations, ...feeDenominations};
  }

  @override
  List<Object?> get props => <Object?>[time, hash, status, direction, memo, fee, txs];
}