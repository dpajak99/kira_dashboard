import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/token_rate_entity.dart';
import 'package:kira_dashboard/infra/repository/token_aliases_repository.dart';
import 'package:kira_dashboard/infra/repository/token_rates_repository.dart';
import 'package:kira_dashboard/models/coin.dart';

class TokensService {
  final TokenRatesRepository tokenRatesRepository = TokenRatesRepository();
  final TokenAliasesRepository tokenAliasesRepository = TokenAliasesRepository();

  Future<List<Coin>> buildCoins(List<SimpleCoin> coins) {
    return Future.wait(coins.map((SimpleCoin simpleCoin) => buildCoin(simpleCoin)));
  }

  Future<Coin> buildCoin(SimpleCoin simpleCoin) async {
    Map<String, TokenAliasEntity> tokenAliasesMap = await tokenAliasesRepository.getAllAsMap();
    Map<String, TokenRateEntity> tokenRatesMap = await tokenRatesRepository.getAllAsMap();



    if(simpleCoin.denom.contains('/')) {
      List<String> derivativeDenom = simpleCoin.denom.split('/');
      String derivativePrefix = derivativeDenom[0];
      String derivativeSuffix = derivativeDenom[1];

      TokenAliasEntity? tokenAlias = tokenAliasesMap[derivativeSuffix];
      TokenRateEntity? tokenRate = tokenRatesMap[derivativeSuffix];

      return DerivativeCoin(
        derivativePrefix: derivativePrefix,
        decimals: tokenAlias?.decimals ?? 0,
        amount: simpleCoin.amount,
        denom: derivativeSuffix,
        symbol: tokenAlias?.symbol ?? derivativeSuffix.toUpperCase(),
        name: tokenAlias?.name ?? simpleCoin.denom,
        icon: tokenAlias?.icon,
        rate: tokenRate?.feeRate,
      );
    } else {
      TokenAliasEntity? tokenAlias = tokenAliasesMap[simpleCoin.denom];
      TokenRateEntity? tokenRate = tokenRatesMap[simpleCoin.denom];

      return Coin(
        type: simpleCoin.denom == 'ukex' ? CoinType.native : CoinType.token,
        decimals: tokenAlias?.decimals ?? 0,
        amount: simpleCoin.amount,
        denom: simpleCoin.denom,
        symbol: tokenAlias?.symbol ?? simpleCoin.denom.toUpperCase(),
        name: tokenAlias?.name ?? simpleCoin.denom,
        icon: tokenAlias?.icon,
        rate: tokenRate?.feeRate,
      );
    }
  }
}
