import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';
import 'package:kira_dashboard/infra/repository/delegations_repository.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/pool_info.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/models/validator_info.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class DelegationsService {
  final DelegationsRepository delegationsRepository = DelegationsRepository();

  DelegationsService();

  Future<PaginatedListWrapper<Delegation>> getPage(String address, PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<DelegationEntity> response = await delegationsRepository.getPage(address, paginatedRequest);
    
    List<Delegation> delegations = response.items.map((e) => Delegation(
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

    return PaginatedListWrapper<Delegation>(items: delegations, total: response.total);
  }
}