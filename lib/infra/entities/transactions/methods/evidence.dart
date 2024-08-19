import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgSubmitEvidence extends TxMsg {
  final String submitter;
  final String evidence;

  MsgSubmitEvidence({
    required this.submitter,
    required this.evidence,
  }) : super(
    action: 'submit_evidence',
    aminoType: 'kiraHub/MsgSubmitEvidence',
    typeUrl: '/kira.gov.MsgSubmitEvidence',
  );

  factory MsgSubmitEvidence.fromData(Map<String, dynamic> data) {
    return MsgSubmitEvidence(
      submitter: data['submitter'] as String,
      evidence: data['evidence'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, submitter),
      ...ProtobufEncoder.encode(2, evidence),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'submitter': submitter,
      'evidence': evidence,
    };
  }

  @override
  String? get from => submitter;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}