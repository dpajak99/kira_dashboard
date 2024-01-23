import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/block_transaction_entity.dart';

class TransactionResultEntity extends Equatable {
  final String hash;
  final String status;
  final int blockHeight;
  final int blockTimestamp;
  final int confirmation;
  final List<TypedMsg> msgs;
  final List<dynamic> transactions;
  final List<CoinEntity> fees;
  final int gasWanted;
  final int gasUsed;
  final String memo;

  TransactionResultEntity.fromJson(Map<String, dynamic> json)
      : hash = json['hash'] as String,
        status = json['status'] as String,
        blockHeight = json['block_height'] as int,
        blockTimestamp = json['block_timestamp'] as int,
        confirmation = json['confirmation'] as int,
        msgs = (json['msgs'] as List<dynamic>).map((e) => TypedMsg.fromJson(e as Map<String, dynamic>)).toList(),
        transactions = json['transactions'] as List<dynamic>,
        fees = (json['fees'] as List<dynamic>).map((e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList(),
        gasWanted = json['gas_wanted'] as int,
        gasUsed = json['gas_used'] as int,
        memo = json['memo'] as String;

  @override
  List<Object?> get props => [hash, status, blockHeight, blockTimestamp, confirmation, msgs, transactions, fees, gasWanted, gasUsed, memo];
}
