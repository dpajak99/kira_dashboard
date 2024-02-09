import 'package:kira_dashboard/infra/entities/staking_pool_dto.dart';
import 'package:kira_dashboard/infra/repository/staking_pool_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/staking_pool.dart';

class StakingPoolService {
  final StakingPoolRepository stakingPoolRepository = StakingPoolRepository();
  final TokensService tokensService = TokensService();

  Future<StakingPool> getByAddress(String address) async {
    StakingPoolDto stakingPoolDto = await stakingPoolRepository.getByAddress(address);
    List<Coin> votingPower = await tokensService.buildCoins(stakingPoolDto.votingPower.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList());

    StakingPool stakingPool = StakingPool(
      id: stakingPoolDto.id,
      slashed: stakingPoolDto.slashed,
      commission: stakingPoolDto.commission,
      totalDelegators: stakingPoolDto.totalDelegators,
      votingPower: votingPower,
      tokens: stakingPoolDto.tokens,
    );

    return stakingPool;
  }
}