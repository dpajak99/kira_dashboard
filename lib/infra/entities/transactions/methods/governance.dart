import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgSubmitProposal extends TxMsg {
  String get name => 'submit-proposal';

  final String proposer;
  final String title;
  final String description;
  final dynamic content;

  MsgSubmitProposal.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        title = json['title'] as String,
        description = json['description'] as String,
        content = json['content'];

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'title': title,
      'description': description,
      'content': content,
    };
  }
}

enum VoteOption {
  unspecified('VOTE_OPTION_UNSPECIFIED'),
  yes('VOTE_OPTION_YES'),
  abstain('VOTE_OPTION_ABSTAIN'),
  no('VOTE_OPTION_NO'),
  noWithWeto('VOTE_OPTION_NO_WITH_VETO');

  final String name;

  const VoteOption(this.name);
}

class MsgVoteProposal extends TxMsg {
  String get name => 'vote-proposal';

  final int proposalId;
  final String voter;
  final VoteOption? option;
  final String slash;

  MsgVoteProposal.fromJson(Map<String, dynamic> json)
      : proposalId = json['proposal_id'] as int,
        voter = json['voter'] as String,
        option = VoteOption.values[json['option'] as int],
        slash = json['slash'] as String;

  @override
  String? get from => voter;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposal_id': proposalId,
      'voter': voter,
      'option': option?.index,
      'slash': slash,
    };
  }
}

class MsgWhitelistPermissions extends TxMsg {
  String get name => 'whitelist-permissions';

  final String proposer;
  final String address;
  final int permission;

  MsgWhitelistPermissions.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        address = json['address'] as String,
        permission = json['permission'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => address;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'address': address,
      'permission': permission,
    };
  }
}

class MsgBlacklistPermissions extends TxMsg {
  String get name => 'blacklist-permissions';

  final String proposer;
  final String address;
  final int permission;

  MsgBlacklistPermissions.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        address = json['address'] as String,
        permission = json['permission'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => address;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'address': address,
      'permission': permission,
    };
  }
}

class MsgClaimCouncilor extends TxMsg {
  String get name => 'claim-councilor';

  final String address;
  final String moniker;
  final String username;
  final String description;
  final String social;
  final String contact;
  final String avatar;

  MsgClaimCouncilor.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        moniker = json['moniker'] as String,
        username = json['username'] as String,
        description = json['description'] as String,
        social = json['social'] as String,
        contact = json['contact'] as String,
        avatar = json['avatar'] as String;

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
      'moniker': moniker,
      'username': username,
      'description': description,
      'social': social,
      'contact': contact,
      'avatar': avatar,
    };
  }
}

class MsgSetNetworkProperties extends TxMsg {
  String get name => 'set-network-properties';

  final dynamic networkProperties;
  final String proposer;

  MsgSetNetworkProperties.fromJson(Map<String, dynamic> json)
      : networkProperties = json['network_properties'],
        proposer = json['proposer'] as String;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'network_properties': networkProperties,
      'proposer': proposer,
    };
  }
}

class MsgSetExecutionFee extends TxMsg {
  String get name => 'set-execution-fee';

  final String transactionType;
  final int executionFee;
  final int failureFee;
  final int timeout;
  final int defaultParameters;
  final String proposer;

  MsgSetExecutionFee.fromJson(Map<String, dynamic> json)
      : transactionType = json['transaction_type'] as String,
        executionFee = json['execution_fee'] as int,
        failureFee = json['failure_fee'] as int,
        timeout = json['timeout'] as int,
        defaultParameters = json['default_parameters'] as int,
        proposer = json['proposer'] as String;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'transaction_type': transactionType,
      'execution_fee': executionFee,
      'failure_fee': failureFee,
      'timeout': timeout,
      'default_parameters': defaultParameters,
      'proposer': proposer,
    };
  }
}

class MsgCreateRole extends TxMsg {
  String get name => 'create-role';

  final String proposer;
  final String roleSid;
  final String roleDescription;

  MsgCreateRole.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        roleSid = json['role_sid'] as String,
        roleDescription = json['role_description'] as String;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'role_sid': roleSid,
      'role_description': roleDescription,
    };
  }
}

class MsgAssignRole extends TxMsg {
  String get name => 'assign-role';

  final String proposer;
  final String address;
  final String roleId;

  MsgAssignRole.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        address = json['address'] as String,
        roleId = json['role_id'] as String;

  @override
  String? get from => proposer;

  @override
  String? get to => address;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'address': address,
      'role_id': roleId,
    };
  }
}

class MsgUnassignRole extends TxMsg {
  String get name => 'unassign-role';

  final String proposer;
  final String address;
  final int roleId;

  MsgUnassignRole.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        address = json['address'] as String,
        roleId = json['role_id'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => address;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'address': address,
      'role_id': roleId,
    };
  }
}

class MsgWhitelistRolePermission extends TxMsg {
  String get name => 'whitelist-role-permission';

  final String proposer;
  final String roleIdentifier;
  final int permission;

  MsgWhitelistRolePermission.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        roleIdentifier = json['role_identifier'] as String,
        permission = json['permission'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'role_identifier': roleIdentifier,
      'permission': permission,
    };
  }
}

class MsgBlacklistRolePermission extends TxMsg {
  String get name => 'blacklist-role-permission';

  final String proposer;
  final String roleIdentifier;
  final int permission;

  MsgBlacklistRolePermission.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        roleIdentifier = json['role_identifier'] as String,
        permission = json['permission'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'role_identifier': roleIdentifier,
      'permission': permission,
    };
  }
}

class MsgRemoveWhitelistRolePermission extends TxMsg {
  String get name => 'remove-whitelist-role-permission';

  final String proposer;
  final String roleIdentifier;
  final int permission;

  MsgRemoveWhitelistRolePermission.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        roleIdentifier = json['role_identifier'] as String,
        permission = json['permission'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'role_identifier': roleIdentifier,
      'permission': permission,
    };
  }
}

class MsgRemoveBlacklistRolePermission extends TxMsg {
  String get name => 'remove-blacklist-role-permission';

  final String proposer;
  final String roleIdentifier;
  final int permission;

  MsgRemoveBlacklistRolePermission.fromJson(Map<String, dynamic> json)
      : proposer = json['proposer'] as String,
        roleIdentifier = json['role_identifier'] as String,
        permission = json['permission'] as int;

  @override
  String? get from => proposer;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'proposer': proposer,
      'role_identifier': roleIdentifier,
      'permission': permission,
    };
  }
}

class IdentityInfoEntry {
  final String key;
  final String info;

  IdentityInfoEntry({
    required this.key,
    required this.info,
  });

  IdentityInfoEntry copyWith({
    String? key,
    String? info,
  }) {
    return IdentityInfoEntry(
      key: key ?? this.key,
      info: info ?? this.info,
    );
  }

  IdentityInfoEntry.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String,
        info = json['info'] as String;

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'info': info,
    };
  }
}

class MsgRegisterIdentityRecords extends TxMsg {
  String get name => 'register-identity-records';

  final String address;
  final List<IdentityInfoEntry> infos;

  MsgRegisterIdentityRecords({
    required this.address,
    required this.infos,
  });

  MsgRegisterIdentityRecords.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        infos = (json['infos'] as List<dynamic>).map((e) => IdentityInfoEntry.fromJson(e as Map<String, dynamic>)).toList();

  @override
  String? get from => address;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> infosJson = infos.map((e) => e.toJson()).toList();
    return {
      'address': address,
      'infos': infosJson,
    };
  }
}

class MsgRequestIdentityRecordsVerify extends TxMsg {
  String get name => 'request-identity-records-verify';

  final String address;
  final String verifier;
  final List<int> recordIds;
  final CoinEntity tip;

  MsgRequestIdentityRecordsVerify({
    required this.address,
    required this.verifier,
    required this.recordIds,
    required this.tip,
  });

  MsgRequestIdentityRecordsVerify.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        verifier = json['verifier'] as String,
        recordIds = (json['record_ids'] as List<dynamic>).map((e) => e as int).toList(),
        tip = CoinEntity.fromJson(json['tip'] as Map<String, dynamic>);

  @override
  String? get from => address;

  @override
  String? get to => verifier;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[tip];

  @override
  Map<String, dynamic> toJson() {
    final List<int> recordIdsJson = recordIds;
    return {
      'address': address,
      'verifier': verifier,
      'record_ids': recordIdsJson,
      'tip': tip.toJson(),
    };
  }
}

class MsgHandleIdentityRecordsVerifyRequest extends TxMsg {
  String get name => 'handle-identity-records-verify-request';

  final String verifier;
  final int verifyRequestId;
  final bool? yes;

  MsgHandleIdentityRecordsVerifyRequest({
    required this.verifier,
    required this.verifyRequestId,
    this.yes,
  });

  MsgHandleIdentityRecordsVerifyRequest.fromJson(Map<String, dynamic> json)
      : verifier = json['verifier'] as String,
        verifyRequestId = json['verify_request_id'] as int,
        yes = json['yes'] as bool?;

  @override
  String? get from => verifier;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    final bool? yesJson = yes;
    return {
      'verifier': verifier,
      'verify_request_id': verifyRequestId,
      'yes': yesJson,
    };
  }
}

class MsgCancelIdentityRecordsVerifyRequest extends TxMsg {
  String get name => 'cancel-identity-records-verify-request';

  final String executor;
  final int verifyRequestId;

  MsgCancelIdentityRecordsVerifyRequest({
    required this.executor,
    required this.verifyRequestId,
  });

  MsgCancelIdentityRecordsVerifyRequest.fromJson(Map<String, dynamic> json)
      : executor = json['executor'] as String,
        verifyRequestId = json['verify_request_id'] as int;

  @override
  String? get from => executor;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'executor': executor,
      'verify_request_id': verifyRequestId,
    };
  }
}
