import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/staking/undelegation_entity.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';
import 'package:kira_dashboard/infra/repository/token_aliases_repository.dart';
import 'package:kira_dashboard/infra/repository/undelegations_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/undelegation.dart';
import 'package:kira_dashboard/models/validator_info.dart';
import 'package:kira_dashboard/utils/custom_date_utils.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class UndelegationsService {
  final TokensService tokensService = TokensService();
  final TokenAliasesRepository tokenAliasesRepository = TokenAliasesRepository();
  final UndelegationsRepository undelegationsRepository = UndelegationsRepository();

  Future<PaginatedListWrapper<Undelegation>> getPage(String address, PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<UndelegationEntity> response = await undelegationsRepository.getPage(address, paginatedRequest);
    List<String> amounts = response.items.fold(<String>{}, (Set<String> previousValue, UndelegationEntity element) {
      previousValue.addAll(element.amounts.map((e) => e.denom));
      return previousValue;
    }).toList();

    Map<String, TokenAliasEntity> coins = await tokenAliasesRepository.getByTokensNameAsMap(amounts);

    List<Undelegation> undelegations = await Future.wait(response.items.map((e) async {
      List<SimpleCoin> amounts = e.amounts.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList();
      return Undelegation(
        id: e.id,
        expiry: CustomDateUtils.buildDateFromSecondsSinceEpoch(int.parse(e.expiry)),
        validatorInfo: ValidatorInfo(
          moniker: e.validatorInfo.moniker,
          address: e.validatorInfo.address,
          valkey: e.validatorInfo.valkey,
          website: e.validatorInfo.website,
          logo: e.validatorInfo.logo,
        ),
        amounts: amounts.map((SimpleCoin e) => tokensService.buildCoinWithAlias(e, coins[e.denom])).toList(),
      );
    }).toList());

    return PaginatedListWrapper<Undelegation>(items: undelegations, total: response.total);
  }
}
