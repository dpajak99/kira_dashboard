import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/repository/balances_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class BalancesService {
  final NetworkListCubit networkListCubit = getIt<NetworkListCubit>();
  final BalancesRepository balancesRepository = BalancesRepository();
  final TokensService tokensService = TokensService();

  Future<PaginatedListWrapper<Coin>> getPage(String address, PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<CoinEntity> response = await balancesRepository.getPage(address, paginatedRequest);
    List<Coin> balance = await tokensService.buildCoins(response.items.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList());
    return PaginatedListWrapper<Coin>(items: balance, total: response.total);
  }

  Future<Coin> getByDenom(String address, String denom) async {
    CoinEntity? coinEntity = await balancesRepository.getByDenom(address, denom);

    if( coinEntity != null ) {
      return tokensService.buildCoin(SimpleCoin(amount: coinEntity.amount, denom: coinEntity.denom));
    } else {
      return tokensService.buildCoin(SimpleCoin(amount: '0', denom: denom));
    }
  }

  Future<Coin> getDefaultCoinBalance(String address) async {
    String defaultCoinDenom = networkListCubit.state.defaultDenom;
    Coin defaultCoinBalance = await getByDenom(address, defaultCoinDenom);
    return defaultCoinBalance;
  }
}
