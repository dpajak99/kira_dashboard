import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgUpsertStakingPool extends TxMsg {
  static String get interxName => 'upsert_staking_pool';

  @override
  String get messageType => '/kira.multistaking.MsgUpsertStakingPool';

  @override
  String get signatureMessageType => 'kiraHub/MsgUpsertStakingPool';

  final String sender;
  final String validator;
  final bool enabled;
  final String commission;

  MsgUpsertStakingPool.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        validator = json['validator'] as String,
        enabled = json['enabled'] as bool,
        commission = json['commission'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => validator;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'validator': validator,
      'enabled': enabled,
      'commission': commission,
    };
  }
}

class MsgDelegate extends TxMsg {
  static String get interxName => 'delegate';

  @override
  String get messageType => '/kira.multistaking.MsgDelegate';

  @override
  String get signatureMessageType => 'kiraHub/MsgDelegate';

  final String delegatorAddress;
  final String validatorAddress;
  final List<CoinEntity> amounts;

  MsgDelegate({
    required this.delegatorAddress,
    required this.validatorAddress,
    required this.amounts,
  });

  MsgDelegate.fromJson(Map<String, dynamic> json)
      : delegatorAddress = json['delegator_address'] as String,
        validatorAddress = json['validator_address'] as String,
        amounts = (json['amounts'] as List<dynamic>).map((e) => CoinEntity.fromJson(e)).toList();

  @override
  String? get from => delegatorAddress;

  @override
  String? get to => validatorAddress;

  @override
  List<CoinEntity> get txAmounts => amounts;

  @override
  Map<String, dynamic> toJson() {
    return {
      'delegator_address': delegatorAddress,
      'validator_address': validatorAddress,
      'amounts': amounts.map((e) => e.toJson()).toList(),
    };
  }
}

class MsgUndelegate extends TxMsg {
  static String get interxName => 'undelegate';

  @override
  String get messageType => '/kira.multistaking.MsgUndelegate';

  @override
  String get signatureMessageType => 'kiraHub/MsgUndelegate';

  final String delegatorAddress;
  final String validatorAddress;
  final List<CoinEntity> amounts;

  MsgUndelegate({
    required this.delegatorAddress,
    required this.validatorAddress,
    required this.amounts,
  });

  MsgUndelegate.fromJson(Map<String, dynamic> json)
      : delegatorAddress = json['delegator_address'] as String,
        validatorAddress = json['validator_address'] as String,
        amounts = (json['amounts'] as List<dynamic>).map((e) => CoinEntity.fromJson(e)).toList();

  @override
  String? get from => delegatorAddress;

  @override
  String? get to => validatorAddress;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'delegator_address': delegatorAddress,
      'validator_address': validatorAddress,
      'amounts': amounts.map((e) => e.toJson()).toList(),
    };
  }
}

class MsgClaimRewards extends TxMsg {
  static String get interxName => 'claim_rewards';

  @override
  String get messageType => '/kira.multistaking.MsgClaimRewards';

  @override
  String get signatureMessageType => 'kiraHub/MsgClaimRewards';

  final String sender;

  MsgClaimRewards({
    required this.sender,
  });

  MsgClaimRewards.fromJson(Map<String, dynamic> json) : sender = json['sender'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
    };
  }
}

class MsgClaimUndelegation extends TxMsg {
  static String get interxName => 'claim_undelegation';

  @override
  String get messageType => '/kira.multistaking.MsgClaimUndelegation';

  @override
  String get signatureMessageType => 'kiraHub/MsgClaimUndelegation';

  final String sender;
  final String undelegationId;

  MsgClaimUndelegation({
    required this.sender,
    required this.undelegationId,
  });

  MsgClaimUndelegation.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        undelegationId = (json['undelegation_id'] as int).toString();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'undelegation_id': undelegationId,
    };
  }
}

class MsgClaimMaturedUndelegations extends TxMsg {
  static String get interxName => 'claim_matured_undelegations';

  @override
  String get messageType => '/kira.multistaking.MsgClaimMaturedUndelegations';

  @override
  String get signatureMessageType => 'kiraHub/MsgClaimMaturedUndelegations';

  final String sender;

  MsgClaimMaturedUndelegations.fromJson(Map<String, dynamic> json) : sender = json['sender'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
    };
  }
}

class MsgSetCompoundInfo extends TxMsg {
  static String get interxName => 'set_compound_info';

  @override
  String get messageType => '/kira.multistaking.MsgSetCompoundInfo';

  @override
  String get signatureMessageType => 'kiraHub/MsgSetCompoundInfo';

  final String sender;
  final bool allDenom;
  final String compoundDenoms;

  MsgSetCompoundInfo.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        allDenom = json['all_denom'] as bool,
        compoundDenoms = json['compound_denoms'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'all_denom': allDenom,
      'compound_denoms': compoundDenoms,
    };
  }
}

class MsgRegisterDelegator extends TxMsg {
  static String get interxName => 'register_delegator';

  @override
  String get messageType => '/kira.multistaking.MsgRegisterDelegator';

  @override
  String get signatureMessageType => 'kiraHub/MsgRegisterDelegator';

  final String delegator;

  MsgRegisterDelegator.fromJson(Map<String, dynamic> json) : delegator = json['delegator'] as String;

  @override
  String? get from => delegator;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'delegator': delegator,
    };
  }
}
