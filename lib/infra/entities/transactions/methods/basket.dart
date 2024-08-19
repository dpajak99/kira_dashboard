import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgDisableBasketDeposits extends TxMsg {
  final String sender;
  final int basketId;
  final bool disabled;

  MsgDisableBasketDeposits({
    required this.sender,
    required this.basketId,
    required this.disabled,
  }) : super(
    action: 'disable-basket-deposits',
    aminoType: 'kiraHub/MsgDisableBasketDeposits',
    typeUrl: '/kira.basket.MsgDisableBasketDeposits',
  );

  factory MsgDisableBasketDeposits.fromData(Map<String, dynamic> data) {
    return MsgDisableBasketDeposits(
      sender: data['sender'] as String,
      basketId: data['basket_id'] as int,
      disabled: data['disabled'] as bool,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketId),
      ...ProtobufEncoder.encode(3, disabled),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_id': basketId,
      'disabled': disabled,
    };
  }

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDisableBasketWithdraws extends TxMsg {
  final String sender;
  final int basketId;
  final bool disabled;

  MsgDisableBasketWithdraws({
    required this.sender,
    required this.basketId,
    required this.disabled,
  }) : super(
    action: 'disable-basket-withdraws',
    aminoType: 'kiraHub/MsgDisableBasketWithdraws',
    typeUrl: '/kira.basket.MsgDisableBasketWithdraws',
  );

  factory MsgDisableBasketWithdraws.fromData(Map<String, dynamic> data) {
    return MsgDisableBasketWithdraws(
      sender: data['sender'] as String,
      basketId: data['basket_id'] as int,
      disabled: data['disabled'] as bool,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketId),
      ...ProtobufEncoder.encode(3, disabled),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_id': basketId,
      'disabled': disabled,
    };
  }


  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDisableBasketSwaps extends TxMsg {
  final String sender;
  final int basketId;
  final bool disabled;

  MsgDisableBasketSwaps({
    required this.sender,
    required this.basketId,
    required this.disabled,
  }) : super(
    action: 'disable-basket-swaps',
    aminoType: 'kiraHub/MsgDisableBasketSwaps',
    typeUrl: '/kira.basket.MsgDisableBasketSwaps',
  );

  factory MsgDisableBasketSwaps.fromData(Map<String, dynamic> data) {
    return MsgDisableBasketSwaps(
      sender: data['sender'] as String,
      basketId: data['basket_id'] as int,
      disabled: data['disabled'] as bool,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketId),
      ...ProtobufEncoder.encode(3, disabled),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_id': basketId,
      'disabled': disabled,
    };
  }

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgBasketTokenMint extends TxMsg {
  final String sender;
  final int basketId;
  final List<String> deposit;

  MsgBasketTokenMint({
    required this.sender,
    required this.basketId,
    required this.deposit,
  }) : super(
    action: 'basket-token-mint',
    aminoType: 'kiraHub/MsgBasketTokenMint',
    typeUrl: '/kira.basket.MsgBasketTokenMint',
  );

  factory MsgBasketTokenMint.fromData(Map<String, dynamic> data) {
    return MsgBasketTokenMint(
      sender: data['sender'] as String,
      basketId: data['basket_id'] as int,
      deposit: (data['deposit'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketId),
      ...ProtobufEncoder.encode(3, deposit),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_id': basketId,
      'deposit': deposit,
    };
  }


  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgBasketTokenBurn extends TxMsg {
  final String sender;
  final int basketId;
  final List<String> burnAmount;

  MsgBasketTokenBurn({
    required this.sender,
    required this.basketId,
    required this.burnAmount,
  }) : super(
    action: 'basket-token-burn',
    aminoType: 'kiraHub/MsgBasketTokenBurn',
    typeUrl: '/kira.basket.MsgBasketTokenBurn',
  );

  factory MsgBasketTokenBurn.fromData(Map<String, dynamic> data) {
    return MsgBasketTokenBurn(
      sender: data['sender'] as String,
      basketId: data['basket_id'] as int,
      burnAmount: (data['burn_amount'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketId),
      ...ProtobufEncoder.encode(3, burnAmount),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_id': basketId,
      'burn_amount': burnAmount,
    };
  }


  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class SwapPair {
  final String inAmount;
  final String outAmount;

  SwapPair({
    required this.inAmount,
    required this.outAmount,
  });

  factory SwapPair.fromData(Map<String, dynamic> data) {
    return SwapPair(
      inAmount: data['in_amount'] as String,
      outAmount: data['out_amount'] as String,
    );
  }

  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, inAmount),
      ...ProtobufEncoder.encode(2, outAmount),
    ]);
  }

  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'in_amount': inAmount,
      'out_amount': outAmount,
    };
  }
}

class MsgBasketTokenSwap extends TxMsg {
  final String sender;
  final int basketId;
  final List<SwapPair> swapPairs;

  MsgBasketTokenSwap({
    required this.sender,
    required this.basketId,
    required this.swapPairs,
  }) : super(
    action: 'basket-token-swap',
    aminoType: 'kiraHub/MsgBasketTokenSwap',
    typeUrl: '/kira.basket.MsgBasketTokenSwap',
  );

  factory MsgBasketTokenSwap.fromData(Map<String, dynamic> data) {
    return MsgBasketTokenSwap(
      sender: data['sender'] as String,
      basketId: data['basket_id'] as int,
      swapPairs: (data['swap_pairs'] as List<dynamic>).map((dynamic e) => SwapPair.fromData(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketId),
      ...ProtobufEncoder.encode(3, swapPairs),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_id': basketId,
      'swap_pairs': swapPairs.map((SwapPair swapPair) => swapPair.toProtoJson()).toList(),
    };
  }


  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgBasketClaimRewards extends TxMsg {
  final String sender;
  final List<String> basketTokens;

  MsgBasketClaimRewards({
    required this.sender,
    required this.basketTokens,
  }) : super(
    action: 'basket-claim-rewards',
    aminoType: 'kiraHub/MsgBasketClaimRewards',
    typeUrl: '/kira.basket.MsgBasketClaimRewards',
  );

  factory MsgBasketClaimRewards.fromData(Map<String, dynamic> data) {
    return MsgBasketClaimRewards(
      sender: data['sender'] as String,
      basketTokens: (data['basket_tokens'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, basketTokens),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'basket_tokens': basketTokens,
    };
  }


  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

