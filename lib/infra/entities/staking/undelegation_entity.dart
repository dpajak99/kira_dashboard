import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/staking/validator_info_entity.dart';

class UndelegationEntity extends Equatable {
  final int id;
  final String expiry;
  final ValidatorInfoEntity validatorInfo;
  final List<CoinEntity> amounts;

  const UndelegationEntity({
    required this.id,
    required this.expiry,
    required this.validatorInfo,
    required this.amounts,
  });

  factory UndelegationEntity.fromJson(Map<String, dynamic> json) {
    return UndelegationEntity(
      id: json['id'] as int,
      expiry: json['expiry'] as String,
      validatorInfo: ValidatorInfoEntity.fromJson(json['validator_info'] as Map<String, dynamic>),
      amounts: (json['tokens'] as List<dynamic>).map((dynamic e) => CoinEntity.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[id, expiry, validatorInfo, amounts];
}
