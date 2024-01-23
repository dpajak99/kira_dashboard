import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgActivate extends TxMsg {
  static String get interxName => 'activate';

  @override
  String get messageType => '/kira.slashing.MsgActivate';

  @override
  String get signatureMessageType => 'kiraHub/MsgActivate';

  final String validatorAddr;

  MsgActivate.fromJson(Map<String, dynamic> json)
      : validatorAddr = json['validator_addr'] as String;

  @override
  String? get from => validatorAddr;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'validator_addr': validatorAddr,
    };
  }
}

class MsgPause extends TxMsg {
  static String get interxName => 'pause';

  @override
  String get messageType => '/kira.slashing.MsgPause';

  @override
  String get signatureMessageType => 'kiraHub/MsgPause';

  final String validatorAddr;

  MsgPause.fromJson(Map<String, dynamic> json)
      : validatorAddr = json['validator_addr'] as String;

  @override
  String? get from => validatorAddr;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'validator_addr': validatorAddr,
    };
  }
}

class MsgUnpause extends TxMsg {
  static String get interxName => 'unpause';

  @override
  String get messageType => '/kira.slashing.MsgUnpause';

  @override
  String get signatureMessageType => 'kiraHub/MsgUnpause';

  final String validatorAddr;

  MsgUnpause.fromJson(Map<String, dynamic> json)
      : validatorAddr = json['validator_addr'] as String;

  @override
  String? get from => validatorAddr;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'validator_addr': validatorAddr,
    };
  }
}
