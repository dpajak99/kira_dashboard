import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgUpsertTokenAlias extends TxMsg {
  String get _name => 'upsert-token-alias';

  final String symbol;
  final String name;
  final String icon;
  final int decimals;
  final List<String> denoms;
  final bool? invalidated;
  final String proposer;

  MsgUpsertTokenAlias.fromJson(Map<String, dynamic> json)
      : symbol = json['symbol'] as String,
        name = json['name'] as String,
        icon = json['icon'] as String,
        decimals = json['decimals'] as int,
        denoms = (json['denoms'] as List<dynamic>).map((e) => e as String).toList(),
        invalidated = json['invalidated'] as bool?,
        proposer = json['proposer'] as String;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'icon': icon,
      'decimals': decimals,
      'denoms': denoms,
      'invalidated': invalidated,
      'proposer': proposer,
    };
  }
}

class MsgUpsertTokenRate extends TxMsg {
  String get name => 'upsert-token-rate';

  final String denom;
  final String rate;
  final bool feePayments;
  final String stakeCap;
  final String stakeMin;
  final bool stakeToken;
  final bool invalidated;
  final String proposer;

  MsgUpsertTokenRate.fromJson(Map<String, dynamic> json)
      : denom = json['denom'] as String,
        rate = json['rate'] as String,
        feePayments = json['fee_payments'] as bool,
        stakeCap = json['stake_cap'] as String,
        stakeMin = json['stake_min'] as String,
        stakeToken = json['stake_token'] as bool,
        invalidated = json['invalidated'] as bool,
        proposer = json['proposer'] as String;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'denom': denom,
      'rate': rate,
      'fee_payments': feePayments,
      'stake_cap': stakeCap,
      'stake_min': stakeMin,
      'stake_token': stakeToken,
      'invalidated': invalidated,
      'proposer': proposer,
    };
  }
}
