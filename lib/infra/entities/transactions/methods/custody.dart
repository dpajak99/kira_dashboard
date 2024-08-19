import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class CustodySettings {
  final bool custodyEnabled;
  final int custodyMode;
  final bool usePassword;
  final bool useWhitelist;
  final bool useLimits;
  final String key;
  final String nextController;

  const CustodySettings({
    required this.custodyEnabled,
    required this.custodyMode,
    required this.usePassword,
    required this.useWhitelist,
    required this.useLimits,
    required this.key,
    required this.nextController,
  });

  factory CustodySettings.fromData(Map<String, dynamic> data) {
    return CustodySettings(
      custodyEnabled: data['custody_enabled'] as bool,
      custodyMode: data['custody_mode'] as int,
      usePassword: data['use_password'] as bool,
      useWhitelist: data['use_white_list'] as bool,
      useLimits: data['use_limits'] as bool,
      key: data['key'] as String,
      nextController: data['next_controller'] as String,
    );
  }

  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, custodyEnabled),
      ...ProtobufEncoder.encode(2, custodyMode),
      ...ProtobufEncoder.encode(3, usePassword),
      ...ProtobufEncoder.encode(4, useWhitelist),
      ...ProtobufEncoder.encode(5, useLimits),
      ...ProtobufEncoder.encode(6, key),
      ...ProtobufEncoder.encode(7, nextController),
    ]);
  }

  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
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
  final String address;
  final CustodySettings custodySettings;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgCreateCustodyRecord({
    required this.address,
    required this.custodySettings,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'create-custody',
    aminoType: 'kiraHub/MsgCreateCustodyRecord',
    typeUrl: '/kira.custody.MsgCreateCustodyRecord',
  );

  factory MsgCreateCustodyRecord.fromData(Map<String, dynamic> data) {
    return MsgCreateCustodyRecord(
      address: data['address'] as String,
      custodySettings: CustodySettings.fromData(data['custody_settings'] as Map<String, dynamic>),
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, custodySettings),
      ...ProtobufEncoder.encode(3, oldKey),
      ...ProtobufEncoder.encode(4, newKey),
      ...ProtobufEncoder.encode(5, nextAddress),
      ...ProtobufEncoder.encode(6, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'custody_settings': custodySettings.toProtoJson(),
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDisableCustodyRecord extends TxMsg {
  final String address;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgDisableCustodyRecord({
    required this.address,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'disable-custody',
    aminoType: 'kiraHub/MsgDisableCustodyRecord',
    typeUrl: '/kira.custody.MsgDisableCustodyRecord',
  );

  factory MsgDisableCustodyRecord.fromData(Map<String, dynamic> data) {
    return MsgDisableCustodyRecord(
      address: data['address'] as String,
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, oldKey),
      ...ProtobufEncoder.encode(3, newKey),
      ...ProtobufEncoder.encode(4, nextAddress),
      ...ProtobufEncoder.encode(5, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDropCustodyRecord extends TxMsg {
  final String address;
  final String oldKey;
  final String targetAddress;

  MsgDropCustodyRecord({
    required this.address,
    required this.oldKey,
    required this.targetAddress,
  }) : super(
    action: 'drop-custody',
    aminoType: 'kiraHub/MsgDropCustodyRecord',
    typeUrl: '/kira.custody.MsgDropCustodyRecord',
  );

  factory MsgDropCustodyRecord.fromData(Map<String, dynamic> data) {
    return MsgDropCustodyRecord(
      address: data['address'] as String,
      oldKey: data['old_key'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, oldKey),
      ...ProtobufEncoder.encode(3, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'old_key': oldKey,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgAddToCustodyWhiteList extends TxMsg {
  final String address;
  final List<String> addAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgAddToCustodyWhiteList({
    required this.address,
    required this.addAddress,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'add-to-custody-whitelist',
    aminoType: 'kiraHub/MsgAddToCustodyWhiteList',
    typeUrl: '/kira.custody.MsgAddToCustodyWhiteList',
  );

  factory MsgAddToCustodyWhiteList.fromData(Map<String, dynamic> data) {
    return MsgAddToCustodyWhiteList(
      address: data['address'] as String,
      addAddress: (data['add_address'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, addAddress),
      ...ProtobufEncoder.encode(3, oldKey),
      ...ProtobufEncoder.encode(4, newKey),
      ...ProtobufEncoder.encode(5, nextAddress),
      ...ProtobufEncoder.encode(6, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'add_address': addAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgAddToCustodyCustodians extends TxMsg {
  final String address;
  final List<String> addAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgAddToCustodyCustodians({
    required this.address,
    required this.addAddress,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'add-to-custody-custodians',
    aminoType: 'kiraHub/MsgAddToCustodyCustodians',
    typeUrl: '/kira.custody.MsgAddToCustodyCustodians',
  );

  factory MsgAddToCustodyCustodians.fromData(Map<String, dynamic> data) {
    return MsgAddToCustodyCustodians(
      address: data['address'] as String,
      addAddress: (data['add_address'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, addAddress),
      ...ProtobufEncoder.encode(3, oldKey),
      ...ProtobufEncoder.encode(4, newKey),
      ...ProtobufEncoder.encode(5, nextAddress),
      ...ProtobufEncoder.encode(6, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'add_address': addAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }


  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgRemoveFromCustodyCustodians extends TxMsg {
  final String address;
  final String removeAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgRemoveFromCustodyCustodians({
    required this.address,
    required this.removeAddress,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'remove-from-custody-custodians',
    aminoType: 'kiraHub/MsgRemoveFromCustodyCustodians',
    typeUrl: '/kira.custody.MsgRemoveFromCustodyCustodians',
  );

  factory MsgRemoveFromCustodyCustodians.fromData(Map<String, dynamic> data) {
    return MsgRemoveFromCustodyCustodians(
      address: data['address'] as String,
      removeAddress: data['remove_address'] as String,
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, removeAddress),
      ...ProtobufEncoder.encode(3, oldKey),
      ...ProtobufEncoder.encode(4, newKey),
      ...ProtobufEncoder.encode(5, nextAddress),
      ...ProtobufEncoder.encode(6, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'remove_address': removeAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDropCustodyCustodians extends TxMsg {
  final String address;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgDropCustodyCustodians({
    required this.address,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'drop-custody-custodians',
    aminoType: 'kiraHub/MsgDropCustodyCustodians',
    typeUrl: '/kira.custody.MsgDropCustodyCustodians',
  );

  factory MsgDropCustodyCustodians.fromData(Map<String, dynamic> data) {
    return MsgDropCustodyCustodians(
      address: data['address'] as String,
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, oldKey),
      ...ProtobufEncoder.encode(3, newKey),
      ...ProtobufEncoder.encode(4, nextAddress),
      ...ProtobufEncoder.encode(5, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgRemoveFromCustodyWhiteList extends TxMsg {
  final String address;
  final String removeAddress;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgRemoveFromCustodyWhiteList({
    required this.address,
    required this.removeAddress,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'remove-from-custody-whitelist',
    aminoType: 'kiraHub/MsgRemoveFromCustodyWhiteList',
    typeUrl: '/kira.custody.MsgRemoveFromCustodyWhiteList',
  );

  factory MsgRemoveFromCustodyWhiteList.fromData(Map<String, dynamic> data) {
    return MsgRemoveFromCustodyWhiteList(
      address: data['address'] as String,
      removeAddress: data['remove_address'] as String,
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, removeAddress),
      ...ProtobufEncoder.encode(3, oldKey),
      ...ProtobufEncoder.encode(4, newKey),
      ...ProtobufEncoder.encode(5, nextAddress),
      ...ProtobufEncoder.encode(6, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'remove_address': removeAddress,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDropCustodyWhiteList extends TxMsg {
  final String address;
  final String oldKey;
  final String newKey;
  final String nextAddress;
  final String targetAddress;

  MsgDropCustodyWhiteList({
    required this.address,
    required this.oldKey,
    required this.newKey,
    required this.nextAddress,
    required this.targetAddress,
  }) : super(
    action: 'drop-custody-whitelist',
    aminoType: 'kiraHub/MsgDropCustodyWhiteLis',
    typeUrl: '/kira.custody.MsgDropCustodyWhiteList',
  );

  factory MsgDropCustodyWhiteList.fromData(Map<String, dynamic> data) {
    return MsgDropCustodyWhiteList(
      address: data['address'] as String,
      oldKey: data['old_key'] as String,
      newKey: data['new_key'] as String,
      nextAddress: data['next_address'] as String,
      targetAddress: data['target_address'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address),
      ...ProtobufEncoder.encode(2, oldKey),
      ...ProtobufEncoder.encode(3, newKey),
      ...ProtobufEncoder.encode(4, nextAddress),
      ...ProtobufEncoder.encode(5, targetAddress),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address,
      'old_key': oldKey,
      'new_key': newKey,
      'next_address': nextAddress,
      'target_address': targetAddress,
    };
  }

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgApproveCustodyTransaction extends TxMsg {
  final String fromAddress;
  final String targetAddress;
  final String hash;

  MsgApproveCustodyTransaction({
    required this.fromAddress,
    required this.targetAddress,
    required this.hash,
  }) : super(
    action: 'approve-custody-transaction',
    aminoType: 'kiraHub/MsgApproveCustodyTransaction',
    typeUrl: '/kira.custody.MsgApproveCustodyTransaction',
  );

  factory MsgApproveCustodyTransaction.fromData(Map<String, dynamic> data) {
    return MsgApproveCustodyTransaction(
      fromAddress: data['from_address'] as String,
      targetAddress: data['target_address'] as String,
      hash: data['hash'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, fromAddress),
      ...ProtobufEncoder.encode(2, targetAddress),
      ...ProtobufEncoder.encode(3, hash),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'from_address': fromAddress,
      'target_address': targetAddress,
      'hash': hash,
    };
  }

  @override
  String? get from => fromAddress;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgDeclineCustodyTransaction extends TxMsg {
  final String fromAddress;
  final String targetAddress;
  final String hash;

  MsgDeclineCustodyTransaction({
    required this.fromAddress,
    required this.targetAddress,
    required this.hash,
  }) : super(
    action: 'decline-custody-transaction',
    aminoType: 'kiraHub/MsgDeclineCustodyTransaction',
    typeUrl: '/kira.custody.MsgDeclineCustodyTransaction',
  );

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, fromAddress),
      ...ProtobufEncoder.encode(2, targetAddress),
      ...ProtobufEncoder.encode(3, hash),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'from_address': fromAddress,
      'target_address': targetAddress,
      'hash': hash,
    };
  }

  @override
  String? get from => fromAddress;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgPasswordConfirmTransaction extends TxMsg {
  final String fromAddress;
  final String targetAddress;
  final String hash;
  final String password;

  MsgPasswordConfirmTransaction({
    required this.fromAddress,
    required this.targetAddress,
    required this.hash,
    required this.password,
  }) : super(
    action: 'password-confirm-transaction',
    aminoType: 'kiraHub/MsgPasswordConfirmTransaction',
    typeUrl: '/kira.custody.MsgPasswordConfirmTransaction',
  );

  factory MsgPasswordConfirmTransaction.fromData(Map<String, dynamic> data) {
    return MsgPasswordConfirmTransaction(
      fromAddress: data['from_address'] as String,
      targetAddress: data['target_address'] as String,
      hash: data['hash'] as String,
      password: data['password'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, fromAddress),
      ...ProtobufEncoder.encode(2, targetAddress),
      ...ProtobufEncoder.encode(3, hash),
      ...ProtobufEncoder.encode(4, password),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'from_address': fromAddress,
      'target_address': targetAddress,
      'hash': hash,
      'password': password,
    };
  }

  @override
  String? get from => fromAddress;

  @override
  String? get to => null;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}

class MsgSend extends TxMsg {
  final String fromAddress;
  final String toAddress;
  final List<String> amount;
  final String password;
  final List<String> reward;

  MsgSend({
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
    required this.password,
    required this.reward,
  }) : super(
    action: 'custody-send',
    aminoType: 'kiraHub/MsgSend',
    typeUrl: '/kira.custody.MsgSend',
  );

  factory MsgSend.fromData(Map<String, dynamic> data) {
    return MsgSend(
      fromAddress: data['from_address'] as String,
      toAddress: data['to_address'] as String,
      amount: (data['amount'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      password: data['password'] as String,
      reward: (data['reward'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, fromAddress),
      ...ProtobufEncoder.encode(2, toAddress),
      ...ProtobufEncoder.encode(3, amount),
      ...ProtobufEncoder.encode(4, password),
      ...ProtobufEncoder.encode(5, reward),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'from_address': fromAddress,
      'to_address': toAddress,
      'amount': amount,
      'password': password,
      'reward': reward,
    };
  }

  @override
  String? get from => fromAddress;

  @override
  String? get to => toAddress;

  @override
  List<CosmosCoin> get txAmounts => <CosmosCoin>[];
}
