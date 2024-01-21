import 'dart:math';

class SimpleCoin {
  final String amount;
  final String denom;

  SimpleCoin({
    required this.amount,
    required this.denom,
  });

  factory SimpleCoin.fromString(String value) {
    RegExp regExpPattern = RegExp(r'(\d+)([a-zA-Z0-9/]+)');
    RegExpMatch regExpMatch = regExpPattern.firstMatch(value)!;

    String amount = regExpMatch.group(1)!;
    String denom = regExpMatch.group(2)!;

    return SimpleCoin(
      amount: amount,
      denom: denom,
    );
  }
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
    this.decimals = 0,
    this.icon,
  });

  Coin copyWith({
    String? amount,
  }) {
    return Coin(
      type: type,
      denom: denom,
      amount: amount ?? this.amount,
      name: name,
      symbol: symbol,
    );
  }

  String toLowestDenominationString() {
    return '$amount $denom';
  }

  String toNetworkDenominationString() {
    return '$networkDenominationAmount $symbol';
  }

  String get networkDenominationAmount {
    double lowestDenomination = double.parse(amount);
    double networkDenomination = lowestDenomination / pow(10, decimals);

    return '$networkDenomination';
  }

  @override
  String toString() {
    return 'Coin{type: $type, denom: $denom, symbol: $symbol, amount: $amount, name: $name, rate: $rate, decimals: $decimals, icon: $icon}';
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
