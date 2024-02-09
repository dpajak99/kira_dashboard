import 'package:kira_dashboard/infra/services/staking_pool_service.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/portfolio_page/validator_info_page/validator_info_page_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class ValidatorInfoPageCubit extends RefreshablePageCubit<ValidatorInfoPageState> {
  final StakingPoolService stakingPoolService = StakingPoolService();
  final Validator validator;

  ValidatorInfoPageCubit({required this.validator}) : super(const ValidatorInfoPageState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const ValidatorInfoPageState(isLoading: true));
    final stakingPool = await stakingPoolService.getByAddress(validator.address);
    emit(ValidatorInfoPageState(stakingPool: stakingPool, isLoading: false));
  }
}
