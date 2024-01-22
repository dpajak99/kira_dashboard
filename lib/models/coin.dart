import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:kira_dashboard/utils/decimal_utils.dart';

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
  final Decimal amount;
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
    Decimal? amount,
  }) {
    return Coin(
      type: type,
      denom: denom,
      amount: amount ?? this.amount,
      name: name,
      symbol: symbol,
    );
  }

  String toLowestDenominationString({bool prettify = false}) {
    if (prettify) {
      return '${DecimalUtils.prettifyDecimal(amount)} $denom';
    } else {
      return '$amount $denom';
    }
  }

  String toNetworkDenominationString({bool prettify = false}) {
    if (prettify) {
      return '${DecimalUtils.prettifyDecimal(networkDenominationAmount)} $symbol';
    } else {
      return '$networkDenominationAmount $symbol';
    }
  }

  Decimal get networkDenominationAmount {
    Decimal lowestDenomination = amount;
    Decimal networkDenomination = lowestDenomination.shift(decimals);

    return networkDenomination;
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
  String toLowestDenominationString({bool prettify = false}) {
    return '${super.toLowestDenominationString(prettify: prettify)} (staked)';
  }

  @override
  String toNetworkDenominationString({bool prettify = false}) {
    return '${super.toNetworkDenominationString(prettify: prettify)} (staked)';
  }
}
