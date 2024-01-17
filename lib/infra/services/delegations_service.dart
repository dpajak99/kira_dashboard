import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';
import 'package:kira_dashboard/infra/repository/delegations_repository.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/pool_info.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/models/validator_info.dart';

class DelegationsService {
  final DelegationsRepository delegationsRepository = DelegationsRepository();

  DelegationsService();

  Future<List<Delegation>> getAll(String address) async {
    List<DelegationEntity> delegationEntities = await delegationsRepository.getAll(address);
    List<Delegation> delegations = delegationEntities.map((e) => Delegation(
      validatorInfo: ValidatorInfo(
        moniker: e.validatorInfo.moniker,
        address: e.validatorInfo.address,
        valkey: e.validatorInfo.valkey,
        website: e.validatorInfo.website,
        logo: e.validatorInfo.logo,
      ),
      poolInfo: PoolInfo(
        id: e.poolInfo.id,
        commission: e.poolInfo.commission,
        status: StakingPoolStatus.fromString(e.poolInfo.status),
        tokens: e.poolInfo.tokens,
      ),
    )).toList();

    return delegations;
  }
}