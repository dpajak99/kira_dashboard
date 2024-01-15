import 'package:kira_dashboard/infra/entities/staking/delegation_entity.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';
import 'package:kira_dashboard/infra/repository/delegations_repository.dart';
import 'package:kira_dashboard/infra/repository/undelegations_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/delegation.dart';
import 'package:kira_dashboard/models/pool_info.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/models/validator_info.dart';
import 'package:kira_dashboard/utils/custom_date_utils.dart';

class UndelegationsService {
  final TokensService tokensService = TokensService();
  final UndelegationsRepository undelegationsRepository = UndelegationsRepository();

  UndelegationsService();

  Future<List<Undelegation>> getAll(String address) async {
    List<UndelegationEntity> undelegationEntities = await undelegationsRepository.getAll(address);
    List<Undelegation> undelegations = await Future.wait(undelegationEntities.map((e) async => Undelegation(
      id: e.id,
      expiry: CustomDateUtils.buildDateFromSecondsSinceEpoch(int.parse(e.expiry)),
      validatorInfo: ValidatorInfo(
        moniker: e.validatorInfo.moniker,
        address: e.validatorInfo.address,
        valkey: e.validatorInfo.valkey,
        website: e.validatorInfo.website,
        logo: e.validatorInfo.logo,
      ),
      amounts: await tokensService.buildCoins(e.amounts.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList()),
    )).toList());

    return undelegations;
  }
}