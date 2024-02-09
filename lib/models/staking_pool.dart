import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/coin.dart';

class StakingPool extends Equatable {
  final int id;
  final String slashed;
  final String commission;
  final int totalDelegators;
  final List<Coin> votingPower;
  final List<String> tokens;

  const StakingPool({
    required this.id,
    required this.slashed,
    required this.commission,
    required this.totalDelegators,
    required this.votingPower,
    required this.tokens,
  });


  String get commissionPercentage {
    return (double.parse(commission) * 100).toStringAsFixed(2);
  }

  String get slashedPercentage {
    return (double.parse(slashed) * 100).toStringAsFixed(2);
  }

  @override
  List<Object?> get props => [id, slashed, commission, totalDelegators, votingPower, tokens];
}
