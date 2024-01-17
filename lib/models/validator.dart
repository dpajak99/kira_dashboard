import 'package:kira_dashboard/infra/entities/validators/validator_entity.dart';

enum StakingPoolStatus {
  withdraw,
  enabled,
  disabled;

  factory StakingPoolStatus.fromString(String? value) {
    switch (value) {
      case 'WITHDRAW':
        return StakingPoolStatus.withdraw;
      case 'ENABLED':
        return StakingPoolStatus.enabled;
      case 'DISABLED':
      default:
        return StakingPoolStatus.disabled;
    }
  }
}

enum ValidatorStatus {
  active,
  inactive,
  jailed,
  paused;

  factory ValidatorStatus.fromString(String? value) {
    switch (value) {
      case 'ACTIVE':
        return ValidatorStatus.active;
      case 'INACTIVE':
        return ValidatorStatus.inactive;
      case 'JAILED':
        return ValidatorStatus.jailed;
      case 'PAUSED':
      default:
        return ValidatorStatus.paused;
    }
  }
}


class Validator {
  final int top;
  final String address;
  final String valkey;
  final String pubkey;
  final String proposer;
  final String moniker;
  final ValidatorStatus status;
  final int rank;
  final String streak;
  final String mischance;
  final String mischanceConfidence;
  final String startHeight;
  final String inactiveUntil;
  final String lastPresentBlock;
  final String missedBlocksCounter;
  final String producedBlocksCounter;
  final String stakingPoolId;
  final StakingPoolStatus stakingPoolStatus;
  final String? website;
  final String? logo;
  final String? social;

  Validator({
    required this.top,
    required this.address,
    required this.valkey,
    required this.pubkey,
    required this.proposer,
    required this.moniker,
    required this.status,
    required this.rank,
    required this.streak,
    required this.mischance,
    required this.mischanceConfidence,
    required this.startHeight,
    required this.inactiveUntil,
    required this.lastPresentBlock,
    required this.missedBlocksCounter,
    required this.producedBlocksCounter,
    required this.stakingPoolId,
    required this.stakingPoolStatus,
    this.website,
    this.logo,
    this.social,
  });

  factory Validator.fromEntity(ValidatorEntity validatorEntity) {
    return Validator(
      top: int.parse(validatorEntity.top),
      address: validatorEntity.address,
      valkey: validatorEntity.valkey,
      pubkey: validatorEntity.pubkey,
      proposer: validatorEntity.proposer,
      moniker: validatorEntity.moniker,
      status: ValidatorStatus.fromString(validatorEntity.status),
      rank: int.parse(validatorEntity.rank),
      streak: validatorEntity.streak,
      mischance: validatorEntity.mischance,
      mischanceConfidence: validatorEntity.mischanceConfidence,
      startHeight: validatorEntity.startHeight,
      inactiveUntil: validatorEntity.inactiveUntil,
      lastPresentBlock: validatorEntity.lastPresentBlock,
      missedBlocksCounter: validatorEntity.missedBlocksCounter,
      producedBlocksCounter: validatorEntity.producedBlocksCounter,
      stakingPoolId: validatorEntity.stakingPoolId,
      stakingPoolStatus: StakingPoolStatus.fromString(validatorEntity.stakingPoolStatus),
      website: validatorEntity.website,
      logo: validatorEntity.logo,
      social: validatorEntity.social,
    );
  }

  int get uptime {
    int producedBlockCounter = int.parse(producedBlocksCounter);
    int missedBlockCounter = int.parse(missedBlocksCounter);

    if (producedBlockCounter + missedBlockCounter > 0) {
      double uptime = producedBlockCounter / (producedBlockCounter + missedBlockCounter) * 100;
      return uptime.round();
    }
    return 0;
  }
}