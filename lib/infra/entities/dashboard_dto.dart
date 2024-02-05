import 'package:equatable/equatable.dart';

class CurrentBlockValidatorDto extends Equatable {
  final String moniker;
  final String address;

  const CurrentBlockValidatorDto({
    required this.moniker,
    required this.address,
  });

  CurrentBlockValidatorDto.fromJson(Map<String, dynamic> json)
      : moniker = json['moniker'] as String,
        address = json['address'] as String;

  @override
  List<Object?> get props => <Object?>[moniker, address];
}

class ValidatorsDto extends Equatable {
  final int activeValidators;
  final int pausedValidators;
  final int inactiveValidators;
  final int jailedValidators;
  final int totalValidators;
  final int waitingValidators;

  const ValidatorsDto({
    required this.activeValidators,
    required this.pausedValidators,
    required this.inactiveValidators,
    required this.jailedValidators,
    required this.totalValidators,
    required this.waitingValidators,
  });

  ValidatorsDto.fromJson(Map<String, dynamic> json)
      : activeValidators = json['active_validators'] as int,
        pausedValidators = json['paused_validators'] as int,
        inactiveValidators = json['inactive_validators'] as int,
        jailedValidators = json['jailed_validators'] as int,
        totalValidators = json['total_validators'] as int,
        waitingValidators = json['waiting_validators'] as int;

  @override
  List<Object?> get props => <Object?>[
        activeValidators,
        pausedValidators,
        inactiveValidators,
        jailedValidators,
        totalValidators,
        waitingValidators,
      ];
}

class BlocksDto extends Equatable {
  final int currentHeight;
  final int sinceGenesis;
  final int pendingTransactions;
  final int currentTransactions;
  final double latestTime;
  final double averageTime;

  const BlocksDto({
    required this.currentHeight,
    required this.sinceGenesis,
    required this.pendingTransactions,
    required this.currentTransactions,
    required this.latestTime,
    required this.averageTime,
  });

  BlocksDto.fromJson(Map<String, dynamic> json)
      : currentHeight = json['current_height'] as int,
        sinceGenesis = json['since_genesis'] as int,
        pendingTransactions = json['pending_transactions'] as int,
        currentTransactions = json['current_transactions'] as int,
        latestTime = json['latest_time'] as double,
        averageTime = json['average_time'] as double;

  @override
  List<Object?> get props => <Object?>[
        currentHeight,
        sinceGenesis,
        pendingTransactions,
        currentTransactions,
        latestTime,
        averageTime,
      ];
}

class ProposalsDto extends Equatable {
  final int total;
  final int active;
  final int enacting;
  final int finished;
  final int successful;
  final String proposers;
  final String voters;

  const ProposalsDto({
    required this.total,
    required this.active,
    required this.enacting,
    required this.finished,
    required this.successful,
    required this.proposers,
    required this.voters,
  });

  ProposalsDto.fromJson(Map<String, dynamic> json)
      : total = json['total'] as int,
        active = json['active'] as int,
        enacting = json['enacting'] as int,
        finished = json['finished'] as int,
        successful = json['successful'] as int,
        proposers = json['proposers'] as String,
        voters = json['voters'] as String;

  @override
  List<Object?> get props => <Object?>[
        total,
        active,
        enacting,
        finished,
        successful,
        proposers,
        voters,
      ];
}

class DashboardDto extends Equatable {
  final String consensusHealth;
  final CurrentBlockValidatorDto currentBlockValidator;
  final ValidatorsDto validators;
  final BlocksDto blocks;
  final ProposalsDto proposals;

  const DashboardDto({
    required this.consensusHealth,
    required this.currentBlockValidator,
    required this.validators,
    required this.blocks,
    required this.proposals,
  });

  DashboardDto.fromJson(Map<String, dynamic> json)
      : consensusHealth = json['consensus_health'] as String,
        currentBlockValidator = CurrentBlockValidatorDto.fromJson(json['current_block_validator'] as Map<String, dynamic>),
        validators = ValidatorsDto.fromJson(json['validators'] as Map<String, dynamic>),
        blocks = BlocksDto.fromJson(json['blocks'] as Map<String, dynamic>),
        proposals = ProposalsDto.fromJson(json['proposals'] as Map<String, dynamic>);

  @override
  List<Object?> get props => <Object?>[
        consensusHealth,
        currentBlockValidator,
        validators,
        blocks,
        proposals,
      ];
}