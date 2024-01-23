import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgDisableBasketDeposits extends TxMsg {
  static String get interxName => 'disable-basket-deposits';

  @override
  String get messageType => '/kira.basket.MsgDisableBasketDeposits';

  @override
  String get signatureMessageType => 'kiraHub/MsgDisableBasketDeposits';

  final String sender;
  final int basketId;

  final bool disabled;

  MsgDisableBasketDeposits.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketId = json['basket_id'] as int,
        disabled = json['disabled'] as bool;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_id': basketId,
      'disabled': disabled,
    };
  }
}

class MsgDisableBasketWithdraws extends TxMsg {
  static String get interxName => 'disable-basket-withdraws';

  @override
  String get messageType => '/kira.basket.MsgDisableBasketWithdraws';

  @override
  String get signatureMessageType => 'kiraHub/MsgDisableBasketWithdraws';

  final String sender;
  final int basketId;

  final bool disabled;

  MsgDisableBasketWithdraws.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketId = json['basket_id'] as int,
        disabled = json['disabled'] as bool;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_id': basketId,
      'disabled': disabled,
    };
  }
}

class MsgDisableBasketSwaps extends TxMsg {
  static String get interxName => 'disable-basket-swaps';

  @override
  String get messageType => '/kira.basket.MsgDisableBasketSwaps';

  @override
  String get signatureMessageType => 'kiraHub/MsgDisableBasketSwaps';

  final String sender;
  final int basketId;

  final bool disabled;

  MsgDisableBasketSwaps.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketId = json['basket_id'] as int,
        disabled = json['disabled'] as bool;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_id': basketId,
      'disabled': disabled,
    };
  }
}

class MsgBasketTokenMint extends TxMsg {
  static String get interxName => 'basket-token-mint';

  @override
  String get messageType => '/kira.basket.MsgBasketTokenMint';

  @override
  String get signatureMessageType => 'kiraHub/MsgBasketTokenMint';

  final String sender;
  final int basketId;

  final List<String> deposit;

  MsgBasketTokenMint.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketId = json['basket_id'] as int,
        deposit = (json['deposit'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_id': basketId,
      'deposit': deposit,
    };
  }
}

class MsgBasketTokenBurn extends TxMsg {
  static String get interxName => 'basket-token-burn';

  @override
  String get messageType => '/kira.basket.MsgBasketTokenBurn';

  @override
  String get signatureMessageType => 'kiraHub/MsgBasketTokenBurn';

  final String sender;
  final int basketId;

  final List<String> burnAmount;

  MsgBasketTokenBurn.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketId = json['basket_id'] as int,
        burnAmount = (json['burn_amount'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_id': basketId,
      'burn_amount': burnAmount,
    };
  }
}

class SwapPair {
  final String inAmount;
  final String outAmount;

  SwapPair.fromJson(Map<String, dynamic> json)
      :
        inAmount = json['in_amount'] as String,
        outAmount = json['out_amount'] as String;
}

class MsgBasketTokenSwap extends TxMsg {
  static String get interxName => 'basket-token-swap';

  @override
  String get messageType => '/kira.basket.MsgBasketTokenSwap';

  @override
  String get signatureMessageType => 'kiraHub/MsgBasketTokenSwap';

  final String sender;
  final int basketId;
  final List<SwapPair> swapPairs;

  MsgBasketTokenSwap.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketId = json['basket_id'] as int,
        swapPairs = (json['swap_pairs'] as List<dynamic>).map((e) => SwapPair.fromJson(e as Map<String, dynamic>)).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_id': basketId,
      'swap_pairs': swapPairs,
    };
  }
}

class MsgBasketClaimRewards extends TxMsg {
  static String get interxName => 'basket-claim-rewards';

  @override
  String get messageType => '/kira.basket.MsgBasketClaimRewards';

  @override
  String get signatureMessageType => 'kiraHub/MsgBasketClaimRewards';

  final String sender;
  final List<String> basketTokens;

  MsgBasketClaimRewards.fromJson(Map<String, dynamic> json)
      :
        sender = json['sender'] as String,
        basketTokens = (json['basket_tokens'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'basket_tokens': basketTokens,
    };
  }
}

