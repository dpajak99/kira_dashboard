import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/repository/balances_repository.dart';
import 'package:kira_dashboard/infra/services/tokens_service.dart';
import 'package:kira_dashboard/models/coin.dart';

class BalancesService {
  final BalancesRepository balancesRepository = BalancesRepository();
  final TokensService tokensService = TokensService();

  Future<List<Coin>> getAll(String address) async {
    List<CoinEntity> balanceEntities = await balancesRepository.getAll(address);
    List<Coin> balance = await tokensService.buildCoins(balanceEntities.map((e) => SimpleCoin(amount: e.amount, denom: e.denom)).toList());
    return balance;
  }
}
