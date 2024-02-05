import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/dashboard_dto.dart';

class CurrentBlockValidator extends Equatable {
  final String moniker;
  final String address;

  const CurrentBlockValidator({
    required this.moniker,
    required this.address,
  });

  CurrentBlockValidator.fromDto(CurrentBlockValidatorDto dto)
      : moniker = dto.moniker,
        address = dto.address;

  @override
  List<Object?> get props => <Object?>[moniker, address];
}

class Validators extends Equatable {
  final int activeValidators;
  final int pausedValidators;
  final int inactiveValidators;
  final int jailedValidators;
  final int totalValidators;
  final int waitingValidators;

  const Validators({
    required this.activeValidators,
    required this.pausedValidators,
    required this.inactiveValidators,
    required this.jailedValidators,
    required this.totalValidators,
    required this.waitingValidators,
  });

  Validators.fromDto(ValidatorsDto dto)
      : activeValidators = dto.activeValidators,
        pausedValidators = dto.pausedValidators,
        inactiveValidators = dto.inactiveValidators,
        jailedValidators = dto.jailedValidators,
        totalValidators = dto.totalValidators,
        waitingValidators = dto.waitingValidators;

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

class Blocks extends Equatable {
  final int currentHeight;
  final int sinceGenesis;
  final int pendingTransactions;
  final int currentTransactions;
  final double latestTime;
  final double averageTime;

  const Blocks({
    required this.currentHeight,
    required this.sinceGenesis,
    required this.pendingTransactions,
    required this.currentTransactions,
    required this.latestTime,
    required this.averageTime,
  });

  Blocks.fromDto(BlocksDto dto)
      : currentHeight = dto.currentHeight,
        sinceGenesis = dto.sinceGenesis,
        pendingTransactions = dto.pendingTransactions,
        currentTransactions = dto.currentTransactions,
        latestTime = dto.latestTime,
        averageTime = dto.averageTime;

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

class Proposals extends Equatable {
  final int total;
  final int active;
  final int enacting;
  final int finished;
  final int successful;
  final String proposers;
  final String voters;

  const Proposals({
    required this.total,
    required this.active,
    required this.enacting,
    required this.finished,
    required this.successful,
    required this.proposers,
    required this.voters,
  });

  Proposals.fromDto(ProposalsDto dto)
      : total = dto.total,
        active = dto.active,
        enacting = dto.enacting,
        finished = dto.finished,
        successful = dto.successful,
        proposers = dto.proposers,
        voters = dto.voters;

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

enum ConsensusStateType {
  healthy,
  unhealthy,
}


class Dashboard extends Equatable {
  final double consensusHealth;
  final CurrentBlockValidator currentBlockValidator;
  final Validators validators;
  final Blocks blocks;
  final Proposals proposals;

  const Dashboard({
    required this.consensusHealth,
    required this.currentBlockValidator,
    required this.validators,
    required this.blocks,
    required this.proposals,
  });

  Dashboard.fromDto(DashboardDto dto)
      : consensusHealth = double.parse(dto.consensusHealth),
        currentBlockValidator = CurrentBlockValidator.fromDto(dto.currentBlockValidator),
        validators = Validators.fromDto(dto.validators),
        blocks = Blocks.fromDto(dto.blocks),
        proposals = Proposals.fromDto(dto.proposals);

  String get consensusHealthPercentage => '${(consensusHealth * 100).round()}%';

  ConsensusStateType get consensusStateType {
    int totalWhitelistedValidators = validators.activeValidators + validators.inactiveValidators + validators.pausedValidators;
    double minActiveValidators = totalWhitelistedValidators * 0.67;

    if (validators.activeValidators >= minActiveValidators) {
      return ConsensusStateType.healthy;
    } else {
      return ConsensusStateType.unhealthy;
    }
  }

  @override
  List<Object?> get props => <Object?>[
    consensusHealth,
    currentBlockValidator,
    validators,
    blocks,
    proposals,
  ];
}