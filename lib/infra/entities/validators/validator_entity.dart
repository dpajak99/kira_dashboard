import 'package:equatable/equatable.dart';

class ValidatorEntity extends Equatable {
  final String top;
  final String address;
  final String valkey;
  final String pubkey;
  final String proposer;
  final String moniker;
  final String status;
  final String rank;
  final String streak;
  final String mischance;
  final String mischanceConfidence;
  final String startHeight;
  final String inactiveUntil;
  final String lastPresentBlock;
  final String missedBlocksCounter;
  final String producedBlocksCounter;
  final String stakingPoolId;
  final String stakingPoolStatus;
  final String? website;
  final String? logo;
  final String? social;


  ValidatorEntity.fromJson(Map<String, dynamic> json)
      : top = json['top'],
        address = json['address'],
        valkey = json['valkey'],
        pubkey = json['pubkey'],
        proposer = json['proposer'],
        moniker = json['moniker'],
        status = json['status'],
        rank = json['rank'],
        streak = json['streak'],
        mischance = json['mischance'],
        mischanceConfidence = json['mischance_confidence'],
        startHeight = json['start_height'],
        inactiveUntil = json['inactive_until'],
        lastPresentBlock = json['last_present_block'],
        missedBlocksCounter = json['missed_blocks_counter'],
        producedBlocksCounter = json['produced_blocks_counter'],
        stakingPoolId = json['staking_pool_id'],
        stakingPoolStatus = json['staking_pool_status'],
        website = json['website'],
        logo = json['logo'],
        social = json['social'];

  @override
  List<Object?> get props =>
      [
        top,
        address,
        valkey,
        pubkey,
        proposer,
        moniker,
        status,
        rank,
        streak,
        mischance,
        mischanceConfidence,
        startHeight,
        inactiveUntil,
        lastPresentBlock,
        missedBlocksCounter,
        producedBlocksCounter,
        stakingPoolId,
        stakingPoolStatus,
        website,
        logo,
        social,
      ];
}