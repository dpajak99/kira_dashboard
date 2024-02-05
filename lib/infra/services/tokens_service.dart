import 'package:decimal/decimal.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/token_rate_entity.dart';
import 'package:kira_dashboard/infra/repository/token_aliases_repository.dart';
import 'package:kira_dashboard/infra/repository/token_rates_repository.dart';
import 'package:kira_dashboard/models/coin.dart';

class TokensService {
  final TokenRatesRepository tokenRatesRepository = TokenRatesRepository();
  final TokenAliasesRepository tokenAliasesRepository = TokenAliasesRepository();

  Map<String, TokenRateEntity> tokenRatesMap = <String, TokenRateEntity>{};



  Future<List<Coin>> buildCoins(List<SimpleCoin> coins) async {
    if (tokenRatesMap.isEmpty) {
      tokenRatesMap = await tokenRatesRepository.getAllAsMap();
    }

    List<String> denoms = coins.map((SimpleCoin simpleCoin) => extractDenom(simpleCoin.denom)).toList();
    Map<String, TokenAliasEntity> tokenAliases = await tokenAliasesRepository.getByTokensNameAsMap(denoms);

    return coins.map((SimpleCoin simpleCoin) {
      TokenAliasEntity? tokenAlias = tokenAliases[extractDenom(simpleCoin.denom)];
      return buildCoinWithAlias(simpleCoin, tokenAlias);
    }).toList();
  }

  Future<Coin> buildCoin(SimpleCoin simpleCoin) async {
    if (tokenRatesMap.isEmpty) {
      tokenRatesMap = await tokenRatesRepository.getAllAsMap();
    }

    String denom = extractDenom(simpleCoin.denom);
    TokenAliasEntity? tokenAlias = (await tokenAliasesRepository.getByTokensNameAsMap([denom]))[denom];

    return buildCoinWithAlias(simpleCoin, tokenAlias);
  }

  String extractDenom(String denom) {
    if (denom.contains('/')) {
      return denom.split('/')[1];
    } else {
      return denom;
    }
  }

  Coin buildCoinWithAlias(SimpleCoin simpleCoin, TokenAliasEntity? tokenAlias) {
    Decimal amount = Decimal.parse(simpleCoin.amount);

    if (simpleCoin.denom.contains('/')) {
      List<String> derivativeDenom = simpleCoin.denom.split('/');
      String derivativePrefix = derivativeDenom[0];
      String derivativeSuffix = derivativeDenom[1];

      TokenRateEntity? tokenRate = tokenRatesMap[derivativeSuffix];

      return DerivativeCoin(
        derivativePrefix: derivativePrefix,
        decimals: tokenAlias?.decimals ?? 0,
        amount: amount,
        denom: derivativeSuffix,
        symbol: tokenAlias?.symbol ?? derivativeSuffix.toUpperCase(),
        name: tokenAlias?.name ?? simpleCoin.denom,
        icon: tokenAlias?.icon,
        rate: tokenRate?.feeRate,
      );
    } else {
      TokenRateEntity? tokenRate = tokenRatesMap[simpleCoin.denom];

      return Coin(
        type: simpleCoin.denom == 'udev' ? CoinType.native : CoinType.token,
        decimals: tokenAlias?.decimals ?? 0,
        amount: amount,
        denom: simpleCoin.denom,
        symbol: tokenAlias?.symbol ?? simpleCoin.denom.toUpperCase(),
        name: tokenAlias?.name ?? simpleCoin.denom,
        icon: tokenAlias?.icon,
        rate: tokenRate?.feeRate,
      );
    }
  }
}
