import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgClaimValidator extends TxMsg {
  String get name => 'claim-validator';

  final String moniker;
  final String valKey;
  final dynamic pubKey;

  MsgClaimValidator.fromJson(Map<String, dynamic> json)
      : moniker = json['moniker'] as String,
        valKey = json['val_key'] as String,
        pubKey = json['pub_key'];

  @override
  String? get from => null;

  @override
  String? get to => null;
}