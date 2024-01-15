import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/validator_info.dart';

class Undelegation {
  final int id;
  final ValidatorInfo validatorInfo;
  final List<Coin> amounts;
  final DateTime expiry;

  Undelegation({
    required this.id,
    required this.validatorInfo,
    required this.amounts,
    required this.expiry,
  });
}
