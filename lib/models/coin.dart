
import 'dart:math';

class SimpleCoin {
  final String amount;
  final String denom;

  SimpleCoin({
    required this.amount,
    required this.denom,
  });
}

enum CoinType {
  native,
  token,
  derivative,
}

class Coin {
  final CoinType type;
  final String denom;
  final String symbol;
  final String amount;
  final String name;
  final String? rate;
  final int decimals;
  final String? icon;

  Coin({
    required this.type,
    required this.denom,
    required this.amount,
    required this.name,
    required this.symbol,
    this.rate,
    this.decimals = 1,
    this.icon,
  });

  String toLowestDenominationString() {
    return '$amount $denom';
  }

  String toNetworkDenominationString() {
    double lowestDenomination = double.parse(amount);
    double networkDenomination = lowestDenomination / pow(10, decimals);

    return '$networkDenomination $symbol';
  }
}

class DerivativeCoin extends Coin {
  final String derivativePrefix;

  DerivativeCoin({
    required this.derivativePrefix,
    required super.denom,
    required super.amount,
    required super.name,
    required super.symbol,
    super.rate,
    super.decimals,
    super.icon,
  }) : super(type: CoinType.derivative);

  @override
  String toLowestDenominationString() {
    return '${super.toLowestDenominationString()} (staked)';
  }

  @override
  String toNetworkDenominationString() {
    return '${super.toNetworkDenominationString()} (staked)';
  }
}
