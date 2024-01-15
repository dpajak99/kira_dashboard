import 'package:kira_dashboard/models/pool_info.dart';
import 'package:kira_dashboard/models/validator_info.dart';

class Delegation {
  final ValidatorInfo validatorInfo;
  final PoolInfo poolInfo;

  Delegation({
    required this.validatorInfo,
    required this.poolInfo,
  });
}
