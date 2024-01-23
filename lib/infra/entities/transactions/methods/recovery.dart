import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgRegisterRecoverySecret extends TxMsg {
  static String get interxNme => 'register-recovery-secret';

  @override
  String get messageType => '/kira.recovery.MsgRegisterRecoverySecret';

  @override
  String get signatureMessageType => 'kiraHub/MsgRegisterRecoverySecret';

  final String address;
  final String challenge;
  final String nonce;
  final String proof;

  MsgRegisterRecoverySecret.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        challenge = json['challenge'] as String,
        nonce = json['nonce'] as String,
        proof = json['proof'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'challenge': challenge,
      'nonce': nonce,
      'proof': proof,
    };
  }
}

class MsgRotateRecoveryAddress extends TxMsg {
  static String get interxName => 'rotate-recovery-address';

  @override
  String get messageType => '/kira.recovery.MsgRotateRecoveryAddress';

  @override
  String get signatureMessageType => 'kiraHub/MsgRotateRecoveryAddress';

  final String feePayer;
  final String address;
  final String recovery;
  final String proof;

  MsgRotateRecoveryAddress.fromJson(Map<String, dynamic> json)
      : feePayer = json['fee_payer'] as String,
        address = json['address'] as String,
        recovery = json['recovery'] as String,
        proof = json['proof'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'fee_payer': feePayer,
      'address': address,
      'recovery': recovery,
      'proof': proof,
    };
  }
}

class MsgIssueRecoveryTokens extends TxMsg {
  static String get interxName => 'issue-recovery-tokens';

  @override
  String get messageType => '/kira.recovery.MsgIssueRecoveryTokens';

  @override
  String get signatureMessageType => 'kiraHub/MsgIssueRecoveryTokens';

  final String address;

  MsgIssueRecoveryTokens.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
    };
  }
}

class MsgBurnRecoveryTokens extends TxMsg {
  static String get interxName => 'burn-recovery-tokens';

  @override
  String get messageType => '/kira.recovery.MsgBurnRecoveryTokens';

  @override
  String get signatureMessageType => 'kiraHub/MsgBurnRecoveryTokens';

  final String address;
  final String rrCoin;

  MsgBurnRecoveryTokens.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        rrCoin = json['rr_coin'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'rr_coin': rrCoin,
    };
  }
}

class MsgRegisterRRTokenHolder extends TxMsg {
  static String get interxName => 'register-rrtoken-holder';

  @override
  String get messageType => '/kira.recovery.MsgRegisterRRTokenHolder';

  @override
  String get signatureMessageType => 'kiraHub/MsgRegisterRRTokenHolder';

  final String holder;

  MsgRegisterRRTokenHolder.fromJson(Map<String, dynamic> json)
      : holder = json['holder'] as String;

  @override
  String? get from => holder;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'holder': holder,
    };
  }
}

class MsgClaimRRHolderRewards extends TxMsg {
  static String get interxName => 'claim-rrholder-rewards';

  @override
  String get messageType => '/kira.recovery.MsgClaimRRHolderRewards';

  @override
  String get signatureMessageType => 'kiraHub/MsgClaimRRHolderRewards';

  final String sender;

  MsgClaimRRHolderRewards.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String;

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
    };
  }
}

class MsgRotateValidatorByHalfRRTokenHolder extends TxMsg {
  static String get interxName => 'rotate-validator-by-half-rr-token-holder';

  @override
  String get messageType => '/kira.recovery.MsgRotateValidatorByHalfRRTokenHolder';

  @override
  String get signatureMessageType => 'kiraHub/MsgRotateValidatorByHalfRRTokenHolder';

  final String rrHolder;
  final String address;
  final String recovery;

  MsgRotateValidatorByHalfRRTokenHolder.fromJson(Map<String, dynamic> json)
      : rrHolder = json['rr_holder'] as String,
        address = json['address'] as String,
        recovery = json['recovery'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'rr_holder': rrHolder,
      'address': address,
      'recovery': recovery,
    };
  }
}

