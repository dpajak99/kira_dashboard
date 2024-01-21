import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgDisableBasketDeposits extends TxMsg {
  String get name => 'disable-basket-deposits';

  final String sender;
  final int basketId ;
  final bool disabled;

  MsgDisableBasketDeposits.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketId = json['basket_id'] as int,
    disabled = json['disabled'] as bool;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

class MsgDisableBasketWithdraws extends TxMsg {
  String get name => 'disable-basket-withdraws';

  final String sender;
  final int basketId ;
  final bool disabled;

  MsgDisableBasketWithdraws.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketId = json['basket_id'] as int,
    disabled = json['disabled'] as bool;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

class MsgDisableBasketSwaps extends TxMsg {
  String get name => 'disable-basket-swaps';

  final String sender;
  final int basketId ;
  final bool disabled;

  MsgDisableBasketSwaps.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketId = json['basket_id'] as int,
    disabled = json['disabled'] as bool;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

class MsgBasketTokenMint extends TxMsg {
  String get name => 'basket-token-mint';

  final String sender;
  final int basketId ;
  final List<String> deposit;

  MsgBasketTokenMint.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketId = json['basket_id'] as int,
    deposit = (json['deposit'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

class MsgBasketTokenBurn extends TxMsg {
  String get name => 'basket-token-burn';

  final String sender;
  final int basketId ;
  final List<String> burnAmount;

  MsgBasketTokenBurn.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketId = json['basket_id'] as int,
    burnAmount = (json['burn_amount'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

class SwapPair {
  final String inAmount;
  final String outAmount;

  SwapPair.fromJson(Map<String, dynamic> json) :
    inAmount = json['in_amount'] as String,
    outAmount = json['out_amount'] as String;
}

class MsgBasketTokenSwap extends TxMsg {
  String get name => 'basket-token-swap';

  final String sender;
  final int basketId;
  final List<SwapPair> swapPairs;

  MsgBasketTokenSwap.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketId = json['basket_id'] as int,
    swapPairs = (json['swap_pairs'] as List<dynamic>).map((e) => SwapPair.fromJson(e as Map<String, dynamic>)).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

class MsgBasketClaimRewards extends TxMsg {
  String get name => 'basket-claim-rewards';

  final String sender;
  final List<String> basketTokens;

  MsgBasketClaimRewards.fromJson(Map<String, dynamic> json) :
    sender = json['sender'] as String,
    basketTokens = (json['basket_tokens'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;
  
  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];
}

