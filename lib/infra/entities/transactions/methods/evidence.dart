import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgSubmitEvidence extends TxMsg {
  String get name => 'submit_evidence';

  final String submitter;
  final String evidence;

  MsgSubmitEvidence.fromJson(Map<String, dynamic> json)
      : submitter = json['submitter'] as String,
        evidence = json['evidence'] as String;

  @override
  String? get from => submitter;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'submitter': submitter,
      'evidence': evidence,
    };
  }
}