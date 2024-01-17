import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgSend extends TxMsg {
  String get name => 'send';

  final String fromAddress;
  final String toAddress;
  final List<CoinEntity> amounts;

  MsgSend.fromJson(Map<String, dynamic> json)
      : fromAddress = json['from_address'] as String,
        toAddress = json['to_address'] as String,
        amounts = (json['amount'] as List<dynamic>).map((dynamic e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList();

  @override
  String? get from => fromAddress;

  @override
  String? get to => toAddress;
}