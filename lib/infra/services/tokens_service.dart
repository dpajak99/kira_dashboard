import 'package:decimal/decimal.dart';
import 'package:kira_dashboard/infra/entities/tokens/aliases/token_alias_entity.dart';
import 'package:kira_dashboard/infra/entities/tokens/rates/token_rate_entity.dart';
import 'package:kira_dashboard/infra/repository/token_aliases_repository.dart';
import 'package:kira_dashboard/infra/repository/token_rates_repository.dart';
import 'package:kira_dashboard/models/coin.dart';

class TokensService {
  final TokenRatesRepository tokenRatesRepository = TokenRatesRepository();
  final TokenAliasesRepository tokenAliasesRepository = TokenAliasesRepository();

  Map<String, TokenAliasEntity> tokenAliasesMap = <String, TokenAliasEntity>{};
  Map<String, TokenRateEntity> tokenRatesMap = <String, TokenRateEntity>{};

  Future<List<Coin>> buildCoins(List<SimpleCoin> coins) async {
    return Future.wait(coins.map((SimpleCoin simpleCoin) => buildCoin(simpleCoin)));
  }

  Future<Coin> buildCoin(SimpleCoin simpleCoin) async {
    if (tokenAliasesMap.isEmpty) {
      tokenAliasesMap = await tokenAliasesRepository.getAllAsMap();
    }

    if (tokenRatesMap.isEmpty) {
      tokenRatesMap = await tokenRatesRepository.getAllAsMap();
    }

    Decimal amount = Decimal.parse(simpleCoin.amount);

    if (simpleCoin.denom.contains('/')) {
      List<String> derivativeDenom = simpleCoin.denom.split('/');
      String derivativePrefix = derivativeDenom[0];
      String derivativeSuffix = derivativeDenom[1];

      TokenAliasEntity? tokenAlias = tokenAliasesMap[derivativeSuffix];
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
      TokenAliasEntity? tokenAlias = tokenAliasesMap[simpleCoin.denom];
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
