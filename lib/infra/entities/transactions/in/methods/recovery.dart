import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgRegisterRecoverySecret extends TxMsg {
  String get name => 'register-recovery-secret';

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
}

class MsgRotateRecoveryAddress extends TxMsg {
  String get name => 'rotate-recovery-address';

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
}

class MsgIssueRecoveryTokens extends TxMsg {
  String get name => 'issue-recovery-tokens';

  final String address;

  MsgIssueRecoveryTokens.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;
}

class MsgBurnRecoveryTokens extends TxMsg {
  String get name => 'burn-recovery-tokens';

  final String address;
  final String rrCoin;

  MsgBurnRecoveryTokens.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        rrCoin = json['rr_coin'] as String;

  @override
  String? get from => address;

  @override
  String? get to => null;
}

class MsgRegisterRRTokenHolder extends TxMsg {
  String get name => 'register-rrtoken-holder';

  final String holder;

  MsgRegisterRRTokenHolder.fromJson(Map<String, dynamic> json)
      : holder = json['holder'] as String;

  @override
  String? get from => holder;

  @override
  String? get to => null;
}

class MsgClaimRRHolderRewards extends TxMsg {
  String get name => 'claim-rrholder-rewards';

  final String sender;

  MsgClaimRRHolderRewards.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;
}

class MsgRotateValidatorByHalfRRTokenHolder extends TxMsg {
  String get name => 'rotate-validator-by-half-rr-token-holder';

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
}

