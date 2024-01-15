import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/staking/pool_info_entity.dart';
import 'package:kira_dashboard/infra/entities/staking/validator_info_entity.dart';

class DelegationEntity extends Equatable {
  final ValidatorInfoEntity validatorInfo;
  final PoolInfoEntity poolInfo;

  const DelegationEntity({
    required this.validatorInfo,
    required this.poolInfo,
  });

  factory DelegationEntity.fromJson(Map<String, dynamic> json) {
    return DelegationEntity(
      validatorInfo: ValidatorInfoEntity.fromJson(json['validator_info'] as Map<String, dynamic>),
      poolInfo: PoolInfoEntity.fromJson(json['pool_info'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[validatorInfo, poolInfo];
}
