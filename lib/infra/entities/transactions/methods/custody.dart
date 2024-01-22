import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class CustodySettings {
  final bool custodyEnabled;
  final int custodyMode;
  final bool usePassword;
  final bool useWhitelist;
  final bool useLimits;
  final String key;
  final String nextController;

  CustodySettings.fromJson(Map<String, dynamic> json)
      : custodyEnabled = json['custody_enabled'] as bool,
        custodyMode = json['custody_mode'] as int,
        usePassword = json['use_password'] as bool,
        useWhitelist = json['use_white_list'] as bool,
        useLimits = json['use_limits'] as bool,
        key = json['key'] as String,
        nextController = json['next_controller'] as String;

  Map<String, dynamic> toJson() {
    return {
      'custody_enabled': custodyEnabled,
      'custody_mode': custodyMode,
      'use_password': usePassword,
      'use_white_list': useWhitelist,
      'use_limits': useLimits,
      'key': key,
      'next_controller': nextController,
    };
  }
}

class MsgCreateCustodyRecord extends TxMsg {
  String get name => 'create-custody';

  final String address;
  final CustodySettings custodySettings;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgCreateCustodyRecord.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        custodySettings = CustodySettings.fromJson(json['custody_settings'] as Map<String, dynamic>),
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'custody_settings': custodySettings.toJson(),
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgDisableCustodyRecord extends TxMsg {
  String get name => 'disable-custody';

  final String address;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgDisableCustodyRecord.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgDropCustodyRecord extends TxMsg {
  String get name => 'drop-custody';

  final String address;
  final String oldKey;
  final String targetAddress;

  MsgDropCustodyRecord.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        oldKey = json['old_key'] as String,
        targetAddress = json['target_address'] as String;

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
      'old_key': oldKey,
      'target_address': targetAddress,
    };
  }
}

class MsgAddToCustodyWhiteList extends TxMsg {
  String get name => 'add-to-custody-whitelist';

  final String address;
  final List<String> addAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgAddToCustodyWhiteList.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        addAddress = (json['add_address'] as List<dynamic>).map((e) => e as String).toList(),
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'add_address': addAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgAddToCustodyCustodians extends TxMsg {
  String get name => 'add-to-custody-custodians';

  final String address;
  final List<String> addAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgAddToCustodyCustodians.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        addAddress = (json['add_address'] as List<dynamic>).map((e) => e as String).toList(),
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'add_address': addAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgRemoveFromCustodyCustodians extends TxMsg {
  String get name => 'remove-from-custody-custodians';

  final String address;
  final String removeAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgRemoveFromCustodyCustodians.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        removeAddress = json['remove_address'] as String,
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'remove_address': removeAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgDropCustodyCustodians extends TxMsg {
  String get name => 'drop-custody-custodians';

  final String address;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgDropCustodyCustodians.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgRemoveFromCustodyWhiteList extends TxMsg {
  String get name => 'remove-from-custody-whitelist';

  final String address;
  final String removeAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgRemoveFromCustodyWhiteList.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        removeAddress = json['remove_address'] as String,
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'remove_address': removeAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgDropCustodyWhiteList extends TxMsg {
  String get name => 'drop-custody-whitelist';

  final String address;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgDropCustodyWhiteList.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        oldKey = json['old_key'] as String,
        newKey = json['new_key'] as String,
        nextAddress = json['next_address'] as String,
        targetAddress = json['target_address'] as String;

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
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }
}

class MsgApproveCustodyTransaction extends TxMsg {
  String get name => 'approve-custody-transaction';

  final String fromAddress;
  final String targetAddress;
  final String hash;

  MsgApproveCustodyTransaction.fromJson(Map<String, dynamic> json)
      : fromAddress = json['from_address'] as String,
        targetAddress = json['target_address'] as String,
        hash = json['hash'] as String;

  @override
  String? get from => fromAddress;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'from_address': fromAddress,
      'target_address': targetAddress,
      'hash': hash,
    };
  }
}

class MsgDeclineCustodyTransaction extends TxMsg {
  String get name => 'decline-custody-transaction';

  final String fromAddress;
  final String targetAddress;
  final String hash;

  MsgDeclineCustodyTransaction.fromJson(Map<String, dynamic> json)
      : fromAddress = json['from_address'] as String,
        targetAddress = json['target_address'] as String,
        hash = json['hash'] as String;

  @override
  String? get from => fromAddress;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'from_address': fromAddress,
      'target_address': targetAddress,
      'hash': hash,
    };
  }
}

class MsgPasswordConfirmTransaction extends TxMsg {
  String get name => 'password-confirm-transaction';

  final String fromAddress;
  final String targetAddress;
  final String hash;
  final String password;

  MsgPasswordConfirmTransaction.fromJson(Map<String, dynamic> json)
      : fromAddress = json['from_address'] as String,
        targetAddress = json['target_address'] as String,
        hash = json['hash'] as String,
        password = json['password'] as String;

  @override
  String? get from => fromAddress;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'from_address': fromAddress,
      'target_address': targetAddress,
      'hash': hash,
      'password': password,
    };
  }
}

class MsgSend extends TxMsg {
  static String get messageName => 'custody-send';

  final String fromAddress;
  final String toAddress;
  final List<String> amount;
  final String password;
  final List<String> reward;

  MsgSend.fromJson(Map<String, dynamic> json)
      : fromAddress = json['from_address'] as String,
        toAddress = json['to_address'] as String,
        amount = (json['amount'] as List<dynamic>).map((e) => e as String).toList(),
        password = json['password'] as String,
        reward = (json['reward'] as List<dynamic>).map((e) => e as String).toList();

  @override
  String? get from => fromAddress;

  @override
  String? get to => toAddress;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'from_address': fromAddress,
      'to_address': toAddress,
      'amount': amount,
      'password': password,
      'reward': reward,
    };
    return data;
  }
}
