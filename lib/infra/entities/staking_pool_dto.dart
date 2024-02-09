import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';

class StakingPoolDto extends Equatable {
  final int id;
  final String slashed;
  final String commission;
  final int totalDelegators;
  final List<CoinEntity> votingPower;
  final List<String> tokens;

  StakingPoolDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        slashed = json['slashed'],
        commission = json['commission'],
        totalDelegators = json['total_delegators'],
        votingPower = (json['voting_power'] as List).map((e) => CoinEntity.fromJson(e)).toList(),
        tokens = List<String>.from(json['tokens']);

  @override
  List<Object?> get props => [id, slashed, commission, totalDelegators, votingPower, tokens];
}