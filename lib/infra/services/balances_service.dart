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

  Future<Coin> getByDenom(String address, String denom) async {
    List<CoinEntity> balanceEntities = await balancesRepository.getAll(address);
    CoinEntity? denomCoin = balanceEntities.where((CoinEntity e) => e.denom == denom).firstOrNull;

    if( denomCoin != null ) {
      return tokensService.buildCoin(SimpleCoin(amount: denomCoin.amount, denom: denomCoin.denom));
    } else {
      return tokensService.buildCoin(SimpleCoin(amount: '0', denom: denom));
    }
  }

  Future<Coin> getDefaultCoinBalance(String address) async {
    String defaultCoinDenom = await tokensService.getDefaultCoinDenom();
    Coin defaultCoinBalance = await getByDenom(address, defaultCoinDenom);
    return defaultCoinBalance;
  }
}
