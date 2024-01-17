import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/validator.dart';

class PoolInfo extends Equatable {
  final int id;
  final String commission;
  final StakingPoolStatus status;
  final List<String> tokens;

  const PoolInfo({
    required this.id,
    required this.commission,
    required this.status,
    required this.tokens,
  });

  String get commissionPercentage => (double.parse(commission) * 100).toStringAsFixed(2);

  @override
  List<Object?> get props => <Object?>[id, commission, status, tokens];
}