import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class TypedMsg extends Equatable {
  final String type;
  final TxMsg data;

  TypedMsg.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        data = TxMsg.fromJsonByName(json['type'], json['data'] as Map<String, dynamic>);

  @override
  List<Object?> get props => <Object>[type, data];
}

class BlockTransactionEntity extends Equatable {
  final String hash;
  final String status;
  final int blockHeight;
  final int blockTimestamp;
  final int confirmation;
  final List<TypedMsg> msgs;
  final List<CoinEntity> fees;
  final int gasWanted;
  final int gasUsed;
  final String memo;

  BlockTransactionEntity.fromJson(Map<String, dynamic> json)
      : hash = json['hash'] as String,
        status = json['status'] as String,
        blockHeight = json['block_height'] as int,
        blockTimestamp = json['block_timestamp'] as int,
        confirmation = json['confirmation'] as int,
        msgs = (json['msgs'] as List<dynamic>).map((e) => TypedMsg.fromJson(e as Map<String, dynamic>)).toList(),
        fees = (json['fees'] as List<dynamic>).map((e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList(),
        gasWanted = json['gas_wanted'] as int,
        gasUsed = json['gas_used'] as int,
        memo = json['memo'] as String;

  @override
  List<Object?> get props => <Object?>[hash, status, blockHeight, blockTimestamp, confirmation, msgs, fees, gasWanted, gasUsed, memo];
}