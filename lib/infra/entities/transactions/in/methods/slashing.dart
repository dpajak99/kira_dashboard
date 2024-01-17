import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgActivate extends TxMsg {
  String get name => 'activate';

  final String validatorAddr;

  MsgActivate.fromJson(Map<String, dynamic> json)
      : validatorAddr = json['validator_addr'] as String;

  @override
  String? get from => validatorAddr;

  @override
  String? get to => null;
}

class MsgPause extends TxMsg {
  String get name => 'pause';

  final String validatorAddr;

  MsgPause.fromJson(Map<String, dynamic> json)
      : validatorAddr = json['validator_addr'] as String;

  @override
  String? get from => validatorAddr;

  @override
  String? get to => null;
}

class MsgUnpause extends TxMsg {
  String get name => 'unpause';

  final String validatorAddr;

  MsgUnpause.fromJson(Map<String, dynamic> json)
      : validatorAddr = json['validator_addr'] as String;

  @override
  String? get from => validatorAddr;

  @override
  String? get to => null;
}
