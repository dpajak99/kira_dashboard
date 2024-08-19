import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class DepositWhitelist {
  final bool any;
  final List<int> roles;
  final List<String> accounts;

  DepositWhitelist({
    required this.any,
    required this.roles,
    required this.accounts,
  });

  factory DepositWhitelist.fromData(Map<String, dynamic> data) {
    return DepositWhitelist(
      any: data['any'] as bool,
      roles: (data['roles'] as List<dynamic>).map((dynamic e) => e as int).toList(),
      accounts: (data['accounts'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, any),
      ...ProtobufEncoder.encode(2, roles),
      ...ProtobufEncoder.encode(3, accounts),
    ]);
  }

  Map<String, dynamic> toProtoJson() {
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

  OwnersWhitelist({
    required this.roles,
    required this.accounts,
  });

  factory OwnersWhitelist.fromData(Map<String, dynamic> data) {
    return OwnersWhitelist(
      roles: (data['roles'] as List<dynamic>).map((dynamic e) => e as int).toList(),
      accounts: (data['accounts'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, roles),
      ...ProtobufEncoder.encode(2, accounts),
    ]);
  }

  Map<String, dynamic> toProtoJson() {
    return {
      'roles': roles,
      'accounts': accounts,
    };
  }
}

class WeightedSpendingPool {
  final String name;
  final int weight;

  WeightedSpendingPool({
    required this.name,
    required this.weight,
  });

  factory WeightedSpendingPool.fromData(Map<String, dynamic> data) {
    return WeightedSpendingPool(
      name: data['name'] as String,
      weight: data['weight'] as int,
    );
  }

  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, name),
      ...ProtobufEncoder.encode(2, weight),
    ]);
  }

  Map<String, dynamic> toProtoJson() {
    return {
      'name': name,
      'weight': weight,
    };
  }
}

class MsgCreateCollective extends TxMsg {
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

  MsgCreateCollective({
    required this.sender,
    required this.name,
    required this.description,
    required this.bonds,
    required this.depositWhitelist,
    required this.ownersWhitelist,
    required this.spendingPools,
    required this.claimStart,
    required this.claimPeriod,
    required this.claimEnd,
    required this.voteQuorum,
    required this.votePeriod,
    required this.voteEnactment,
  }) : super(
    action: 'create-collective',
    aminoType: 'kiraHub/MsgCreateCollective',
    typeUrl: '/kira.collectives.MsgCreateCollective',
  );

  factory MsgCreateCollective.fromData(Map<String, dynamic> data) {
    return MsgCreateCollective(
      sender: data['sender'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      bonds: (data['bonds'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      depositWhitelist: DepositWhitelist.fromData(data['deposit_whitelist'] as Map<String, dynamic>),
      ownersWhitelist: OwnersWhitelist.fromData(data['owners_whitelist'] as Map<String, dynamic>),
      spendingPools: (data['spending_pools'] as List<dynamic>).map((dynamic e) => WeightedSpendingPool.fromData(e as Map<String, dynamic>)).toList(),
      claimStart: data['claim_start'] as int,
      claimPeriod: data['claim_period'] as int,
      claimEnd: data['claim_end'] as int,
      voteQuorum: data['vote_quorum'] as int,
      votePeriod: data['vote_period'] as int,
      voteEnactment: data['vote_enactment'] as int,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, name),
      ...ProtobufEncoder.encode(3, description),
      ...ProtobufEncoder.encode(4, bonds),
      ...ProtobufEncoder.encode(5, depositWhitelist),
      ...ProtobufEncoder.encode(6, ownersWhitelist),
      ...ProtobufEncoder.encode(7, spendingPools),
      ...ProtobufEncoder.encode(8, claimStart),
      ...ProtobufEncoder.encode(9, claimPeriod),
      ...ProtobufEncoder.encode(10, claimEnd),
      ...ProtobufEncoder.encode(11, voteQuorum),
      ...ProtobufEncoder.encode(12, votePeriod),
      ...ProtobufEncoder.encode(13, voteEnactment),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'name': name,
      'description': description,
      'bonds': bonds,
      'deposit_whitelist': depositWhitelist.toProtoJson(),
      'owners_whitelist': ownersWhitelist.toProtoJson(),
      'spending_pools': spendingPools.map((WeightedSpendingPool e) => e.toProtoJson()).toList(),
      'claim_start': claimStart,
      'claim_period': claimPeriod,
      'claim_end': claimEnd,
      'vote_quorum': voteQuorum,
      'vote_period': votePeriod,
      'vote_enactment': voteEnactment,
    };
  }

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}


class MsgBondCollective extends TxMsg {
  final String sender;
  final String name;
  final List<String> bonds;

  MsgBondCollective({
    required this.sender,
    required this.name,
    required this.bonds,
  }) : super(
    action: 'bond-collective',
    aminoType: 'kiraHub/MsgBondCollective',
    typeUrl: '/kira.collectives.MsgBondCollective',
  );

  factory MsgBondCollective.fromData(Map<String, dynamic> data) {
    return MsgBondCollective(
      sender: data['sender'] as String,
      name: data['name'] as String,
      bonds: (data['bonds'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, name),
      ...ProtobufEncoder.encode(3, bonds),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'name': name,
      'bonds': bonds,
    };
  }

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}


class MsgDonateCollective extends TxMsg {
  final String sender;
  final String name;
  final int locking;
  final String donation;
  final bool donationLock;

  MsgDonateCollective({
    required this.sender,
    required this.name,
    required this.locking,
    required this.donation,
    required this.donationLock,
  }) : super(
    action: 'donate-collective',
    aminoType: 'kiraHub/MsgDonateCollective',
    typeUrl: '/kira.collectives.MsgDonateCollective',
  );

  factory MsgDonateCollective.fromData(Map<String, dynamic> data) {
    return MsgDonateCollective(
      sender: data['sender'] as String,
      name: data['name'] as String,
      locking: data['locking'] as int,
      donation: data['donation'] as String,
      donationLock: data['donation_lock'] as bool,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, name),
      ...ProtobufEncoder.encode(3, locking),
      ...ProtobufEncoder.encode(4, donation),
      ...ProtobufEncoder.encode(5, donationLock),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'name': name,
      'locking': locking,
      'donation': donation,
      'donation_lock': donationLock,
    };
  }

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}


class MsgWithdrawCollective extends TxMsg {
  final String sender;
  final String name;

  MsgWithdrawCollective({
    required this.sender,
    required this.name,
  }) : super(
    action: 'withdraw-collective',
    aminoType: 'kiraHub/MsgWithdrawCollective',
    typeUrl: '/kira.collectives.MsgWithdrawCollective',
  );

  factory MsgWithdrawCollective.fromData(Map<String, dynamic> data) {
    return MsgWithdrawCollective(
      sender: data['sender'] as String,
      name: data['name'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, name),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'name': name,
    };
  }

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}


