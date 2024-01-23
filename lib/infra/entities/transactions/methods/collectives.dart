import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class DepositWhitelist {
  final bool any;
  final List<int> roles;
  final List<String> accounts;

  DepositWhitelist.fromJson(Map<String, dynamic> json) :
    any = json['any'] as bool,
    roles = (json['roles'] as List<dynamic>).map((e) => e as int).toList(),
    accounts = (json['accounts'] as List<dynamic>).map((e) => e as String).toList();

  Map<String, dynamic> toJson() {
    return {
      'any': any,
      'roles': roles,
      'accounts': accounts,
    };
  }
}

class OwnersWhitelist {
  final List<int> roles;
  final List<String> accounts;

  OwnersWhitelist.fromJson(Map<String, dynamic> json) :
        roles = (json['roles'] as List<dynamic>).map((e) => e as int).toList(),
        accounts = (json['accounts'] as List<dynamic>).map((e) => e as String).toList();

  Map<String, dynamic> toJson() {
    return {
      'roles': roles,
      'accounts': accounts,
    };
  }
}

class WeightedSpendingPool {
  final String name;
  final int weight;

  WeightedSpendingPool.fromJson(Map<String, dynamic> json) :
        name = json['name'] as String,
        weight = json['weight'] as int;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
    };
  }
}

class MsgCreateCollective extends TxMsg {
  static String get interxName => 'create-collective';

  @override
  String get messageType => '/kira.collectives.MsgCreateCollective';

  @override
  String get signatureMessageType => 'kiraHub/MsgCreateCollective';

  final String sender;
  final String name;
  final String description;
  final List<String> bonds;
  final DepositWhitelist depositWhitelist;
  final OwnersWhitelist ownersWhitelist;
  final List<WeightedSpendingPool> spendingPools;
  final int claimStart;
  final int claimPeriod;
  final int claimEnd;
  final int voteQuorum;
  final int votePeriod;
  final int voteEnactment;

  MsgCreateCollective.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    name = json['name'] as String,
    description = json['description'] as String,
    bonds = (json['bonds'] as List<dynamic>).map((e) => e as String).toList(),
    depositWhitelist = DepositWhitelist.fromJson(json['deposit_whitelist'] as Map<String, dynamic>),
    ownersWhitelist = OwnersWhitelist.fromJson(json['owners_whitelist'] as Map<String, dynamic>),
    spendingPools = (json['spending_pools'] as List<dynamic>).map((e) => WeightedSpendingPool.fromJson(e as Map<String, dynamic>)).toList(),
    claimStart = json['claim_start'] as int,
    claimPeriod = json['claim_period'] as int,
    claimEnd = json['claim_end'] as int,
    voteQuorum = json['vote_quorum'] as int,
    votePeriod = json['vote_period'] as int,
    voteEnactment = json['vote_enactment'] as int;

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
      'name': name,
      'description': description,
      'bonds': bonds,
      'deposit_whitelist': depositWhitelist.toJson(),
      'owners_whitelist': ownersWhitelist.toJson(),
      'spending_pools': spendingPools.map((e) => e.toJson()).toList(),
      'claim_start': claimStart,
      'claim_period': claimPeriod,
      'claim_end': claimEnd,
      'vote_quorum': voteQuorum,
      'vote_period': votePeriod,
      'vote_enactment': voteEnactment,
    };
  }
}


class MsgBondCollective extends TxMsg {
  static String get interxName => 'bond-collective';

  @override
  String get messageType => '/kira.collectives.MsgBondCollective';

  @override
  String get signatureMessageType => 'kiraHub/MsgBondCollective';

  final String sender;
  final String name;
  final List<String> bonds;

  MsgBondCollective.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    name = json['name'] as String,
    bonds = (json['bonds'] as List<dynamic>).map((e) => e as String).toList();

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
      'name': name,
      'bonds': bonds,
    };
  }
}


class MsgDonateCollective extends TxMsg {
  static String get interxName => 'donate-collective';

  @override
  String get messageType => '/kira.collectives.MsgDonateCollective';

  @override
  String get signatureMessageType => 'kiraHub/MsgDonateCollective';

  final String sender;
  final String name;
  final int locking;
  final String donation;
  final bool donationLock;

  MsgDonateCollective.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    name = json['name'] as String,
    locking = json['locking'] as int,
    donation = json['donation'] as String,
    donationLock = json['donation_lock'] as bool;

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
      'name': name,
      'locking': locking,
      'donation': donation,
      'donation_lock': donationLock,
    };
  }
}


class MsgWithdrawCollective extends TxMsg {
  static String get interxName => 'withdraw-collective';

  @override
  String get messageType => '/kira.collectives.MsgWithdrawCollective';

  @override
  String get signatureMessageType => 'kiraHub/MsgWithdrawCollective';

  final String sender;
  final String name;

  MsgWithdrawCollective.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    name = json['name'] as String;

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
      'name': name,
    };
  }
}


