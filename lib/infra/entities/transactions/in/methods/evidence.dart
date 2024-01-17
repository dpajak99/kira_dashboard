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
}