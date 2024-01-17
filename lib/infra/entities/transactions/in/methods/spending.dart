import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class PermInfo {
  final String account;
  final String poolName;
  final int lastClaim;

  PermInfo.fromJson(Map<String, dynamic> json)
      : account = json['account'] as String,
        poolName = json['pool_name'] as String,
        lastClaim = json['last_claim'] as int;
}

class WeightedPermInfo {
  final WeightedRole roles;
  final WeightedAccount accounts;

  WeightedPermInfo.fromJson(Map<String, dynamic> json)
      : roles = json['roles'] as WeightedRole,
        accounts = json['accounts'] as WeightedAccount;
}

class WeightedRole {
  final String role;
  final int weight;

  WeightedRole.fromJson(Map<String, dynamic> json)
      : role = json['role'] as String,
        weight = json['weight'] as int;
}

class WeightedAccount {
  final String account;
  final int weight;

  WeightedAccount.fromJson(Map<String, dynamic> json)
      : account = json['account'] as String,
        weight = json['weight'] as int;
}

class MsgCreateSpendingPool extends TxMsg {
  String get _name => 'create-spending-pool';

  final String name;
  final int claimStart;
  final int claimEnd;
  final int claimexpiry;
  final List<String> rates;
  final int voteQuorum;
  final int votePeriod;
  final int voteEnactment;
  final PermInfo owners;
  final WeightedPermInfo beneficiaries;
  final String sender;
  final bool dynamicRate;
  final int dynamicRatePeriod;

  MsgCreateSpendingPool.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        claimStart = json['claim_start'] as int,
        claimEnd = json['claim_end'] as int,
        claimexpiry = json['claim_expiry'] as int,
        rates = (json['rates'] as List<dynamic>).map((e) => e as String).toList(),
        voteQuorum = json['vote_quorum'] as int,
        votePeriod = json['vote_period'] as int,
        voteEnactment = json['vote_enactment'] as int,
        owners = PermInfo.fromJson(json['owners'] as Map<String, dynamic>),
        beneficiaries = WeightedPermInfo.fromJson(json['beneficiaries'] as Map<String, dynamic>),
        sender = json['sender'] as String,
        dynamicRate = json['dynamic_rate'] as bool,
        dynamicRatePeriod = json['dynamic_rate_period'] as int;

  @override
  String? get from => sender;

  @override
  String? get to => null;
}

class MsgDepositSpendingPool extends TxMsg {
  String get name => 'deposit-spending-pool';

  final String sender;
  final bool dynamicRate;
  final int dynamicRatePeriod;

  MsgDepositSpendingPool.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dynamicRate = json['dynamic_rate'] as bool,
        dynamicRatePeriod = json['dynamic_rate_period'] as int;

  @override
  String? get from => sender;

  @override
  String? get to => null;
}

class MsgRegisterSpendingPoolBeneficiary extends TxMsg {
  String get name => 'register-spending-pool-beneficiary';

  final String sender;
  final String poolName;

  MsgRegisterSpendingPoolBeneficiary.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        poolName = json['pool_name'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;
}

class MsgClaimSpendingPool extends TxMsg {
  String get name => 'claim-spending-pool';

  final String sender;
  final String poolName;

  MsgClaimSpendingPool.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        poolName = json['pool_name'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;
}

