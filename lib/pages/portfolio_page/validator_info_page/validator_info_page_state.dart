import 'package:kira_dashboard/models/staking_pool.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class ValidatorInfoPageState extends PageState {
  final StakingPool? stakingPool;

  const ValidatorInfoPageState({this.stakingPool, required super.isLoading});

  @override
  List<Object?> get props => [stakingPool];
}