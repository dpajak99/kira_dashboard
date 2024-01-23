import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgCreateDappProposal extends TxMsg {
  static String get interxName => 'create-dapp-proposal';

  @override
  String get messageType => '/kira.layer2.MsgCreateDappProposal';

  @override
  String get signatureMessageType => 'kiraHub/MsgCreateDappProposal';

  final String sender;
  final dynamic dapp;
  final String bond;

  MsgCreateDappProposal.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dapp = json['dapp'] as dynamic,
        bond = json['bond'] as String;

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
      'dapp': dapp,
      'bond': bond,
    };
  }
}

class MsgBondDappProposal extends TxMsg {
  static String get interxName => 'bond-dapp-proposal';

  @override
  String get messageType => '/kira.layer2.MsgBondDappProposal';

  @override
  String get signatureMessageType => 'kiraHub/MsgBondDappProposal';

  final String sender;
  final String dappName;
  final String bond;

  MsgBondDappProposal.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        bond = json['bond'] as String;

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
      'dapp_name': dappName,
      'bond': bond,
    };
  }
}

class MsgReclaimDappBondProposal extends TxMsg {
  static String get interxName => 'reclaim-dapp-bond-proposal';

  @override
  String get messageType => '/kira.layer2.MsgReclaimDappBondProposal';

  @override
  String get signatureMessageType => 'kiraHub/MsgReclaimDappBondProposal';

  final String sender;
  final String dappName;
  final String bond;

  MsgReclaimDappBondProposal.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        bond = json['bond'] as String;

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
      'dapp_name': dappName,
      'bond': bond,
    };
  }
}

class MsgJoinDappVerifierWithBond extends TxMsg {
  static String get interxName => 'join-dapp-verifier-with-bond';

  @override
  String get messageType => '/kira.layer2.MsgJoinDappVerifierWithBond';

  @override
  String get signatureMessageType => 'kiraHub/MsgJoinDappVerifierWithBond';

  final String sender;
  final String dappName;
  final String interx;

  MsgJoinDappVerifierWithBond.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        interx = json['interx'] as String;

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
      'dapp_name': dappName,
      'interx': interx,
    };
  }
}

class MsgExitDapp extends TxMsg {
  static String get interxName => 'exit-dapp';

  @override
  String get messageType => '/kira.layer2.MsgExitDapp';

  @override
  String get signatureMessageType => 'kiraHub/MsgExitDapp';

  final String sender;
  final String dappName;

  MsgExitDapp.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String;

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
      'dapp_name': dappName,
    };
  }
}

class MsgRedeemDappPoolTx extends TxMsg {
  static String get interxName => 'redeem-dapp-pool-tx';

  @override
  String get messageType => '/kira.layer2.MsgRedeemDappPoolTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgRedeemDappPoolTx';

  final String sender;
  final String dappName;
  final String lpToken;
  final String slippage;

  MsgRedeemDappPoolTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        lpToken = json['lp_token'] as String,
        slippage = json['slippage'] as String;

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
      'dapp_name': dappName,
      'lp_token': lpToken,
      'slippage': slippage,
    };
  }
}

class MsgSwapDappPoolTx extends TxMsg {
  static String get interxName => 'swap-dapp-pool-tx';

  @override
  String get messageType => '/kira.layer2.MsgSwapDappPoolTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgSwapDappPoolTx';

  final String sender;
  final String dappName;
  final String token;
  final String slippage;

  MsgSwapDappPoolTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        token = json['token'] as String,
        slippage = json['slippage'] as String;

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
      'dapp_name': dappName,
      'token': token,
      'slippage': slippage,
    };
  }
}

class MsgConvertDappPoolTx extends TxMsg {
  static String get interxName => 'convert-dapp-pool-tx';

  @override
  String get messageType => '/kira.layer2.MsgConvertDappPoolTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgConvertDappPoolTx';

  final String sender;
  final String dappName;
  final String targetDappName;
  final String lpToken;

  MsgConvertDappPoolTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        targetDappName = json['target_dapp_name'] as String,
        lpToken = json['lp_token'] as String;

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
      'dapp_name': dappName,
      'target_dapp_name': targetDappName,
      'lp_token': lpToken,
    };
  }
}

class MsgPauseDappTx extends TxMsg {
  static String get interxName => 'pause-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgPauseDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgPauseDappTx';

  final String sender;
  final String dappName;

  MsgPauseDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String;

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
      'dapp_name': dappName,
    };
  }
}

class MsgUnPauseDappTx extends TxMsg {
  static String get interxName => 'unpause-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgUnPauseDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgUnPauseDappTx';

  final String sender;
  final String dappName;

  MsgUnPauseDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String;

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
      'dapp_name': dappName,
    };
  }
}

class MsgReactivateDappTx extends TxMsg {
  static String get interxName => 'reactivate-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgReactivateDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgReactivateDappTx';

  final String sender;
  final String dappName;

  MsgReactivateDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String;

  @override
  String? get from => sender;

  @override
  String? get to => null;

  @override
  List<CoinEntity> get txAmounts => <CoinEntity>[];

  @override
  Map<String, dynamic> toJson() {
    return {
      'dapp_name': dappName,
    };
  }
}

class MsgExecuteDappTx extends TxMsg {
  static String get interxName => 'execute-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgExecuteDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgExecuteDappTx';

  final String sender;
  final String dappName;
  final String gateway;

  MsgExecuteDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        gateway = json['gateway'] as String;

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
      'dapp_name': dappName,
      'gateway': gateway,
    };
  }
}

class MsgDenounceLeaderTx extends TxMsg {
  static String get interxName => 'denounce-leader-tx';

  @override
  String get messageType => '/kira.layer2.MsgDenounceLeaderTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgDenounceLeaderTx';

  final String sender;
  final String dappName;
  final String leader;
  final String denounceText;
  final String version;

  MsgDenounceLeaderTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        leader = json['leader'] as String,
        denounceText = json['denounce_text'] as String,
        version = json['version'] as String;

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
      'dapp_name': dappName,
      'leader': leader,
      'denounce_text': denounceText,
      'version': version,
    };
  }
}

class MsgTransitionDappTx extends TxMsg {
  static String get interxName => 'transition-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgTransitionDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgTransitionDappTx';

  final String sender;
  final String dappName;
  final String statusHash;
  final dynamic onchainMessages;
  final String version;

  MsgTransitionDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        statusHash = json['status_hash'] as String,
        onchainMessages = json['onchain_messages'] as dynamic,
        version = json['version'] as String;

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
      'dapp_name': dappName,
      'status_hash': statusHash,
      'onchain_messages': onchainMessages,
      'version': version,
    };
  }
}

class MsgApproveDappTransitionTx extends TxMsg {
  static String get interxName => 'approve-dapp-transition-tx';

  @override
  String get messageType => '/kira.layer2.MsgApproveDappTransitionTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgApproveDappTransitionTx';

  final String sender;
  final String dappName;
  final String version;

  MsgApproveDappTransitionTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        version = json['version'] as String;

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
      'dapp_name': dappName,
      'version': version,
    };
  }
}

class MsgRejectDappTransitionTx extends TxMsg {
  static String get interxName => 'reject-dapp-transition-tx';

  @override
  String get messageType => '/kira.layer2.MsgRejectDappTransitionTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgRejectDappTransitionTx';

  final String sender;
  final String dappName;
  final String version;

  MsgRejectDappTransitionTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        dappName = json['dapp_name'] as String,
        version = json['version'] as String;

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
      'dapp_name': dappName,
      'version': version,
    };
  }
}

class MsgTransferDappTx extends TxMsg {
  static String get interxName => 'transfer-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgTransferDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgTransferDappTx';

  final String sender;
  final List<dynamic> requests;

  MsgTransferDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        requests = json['requests'] as List<dynamic>;

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
      'requests': requests,
    };
  }
}

class MsgAckTransferDappTx extends TxMsg {
  static String get interxName => 'ack-transfer-dapp-tx';

  @override
  String get messageType => '/kira.layer2.MsgAckTransferDappTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgAckTransferDappTx';

  final String sender;
  final List<dynamic> responses;

  MsgAckTransferDappTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        responses = json['responses'] as List<dynamic>;

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
      'responses': responses,
    };
  }
}

class MsgMintCreateFtTx extends TxMsg {
  static String get interxName => 'mint-create-ft-tx';

  @override
  String get messageType => '/kira.layer2.MsgMintCreateFtTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgMintCreateFtTx';

  final String sender;
  final String denomSuffix;
  final String name;
  final String symbol;
  final String icon;
  final String description;
  final String website;
  final String social;
  final int decimals;
  final String cap;
  final String supply;
  final int holders;
  final String fee;
  final String owner;

  MsgMintCreateFtTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        denomSuffix = json['denom_suffix'] as String,
        name = json['name'] as String,
        symbol = json['symbol'] as String,
        icon = json['icon'] as String,
        description = json['description'] as String,
        website = json['website'] as String,
        social = json['social'] as String,
        decimals = json['decimals'] as int,
        cap = json['cap'] as String,
        supply = json['supply'] as String,
        holders = json['holders'] as int,
        fee = json['fee'] as String,
        owner = json['owner'] as String;

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
      'denom_suffix': denomSuffix,
      'name': name,
      'symbol': symbol,
      'icon': icon,
      'description': description,
      'website': website,
      'social': social,
      'decimals': decimals,
      'cap': cap,
      'supply': supply,
      'holders': holders,
      'fee': fee,
      'owner': owner,
    };
  }
}

class MsgMintCreateNftTx extends TxMsg {
  static String get interxName => 'mint-create-nft-tx';

  @override
  String get messageType => '/kira.layer2.MsgMintCreateNftTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgMintCreateNftTx';

  final String sender;
  final String denomSuffix;
  final String name;
  final String symbol;
  final String icon;
  final String description;
  final String website;
  final String social;
  final String decimals;
  final String cap;
  final String supply;
  final int holders;
  final String fee;
  final String owner;
  final String metadata;
  final String hash;

  MsgMintCreateNftTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        denomSuffix = json['denom_suffix'] as String,
        name = json['name'] as String,
        symbol = json['symbol'] as String,
        icon = json['icon'] as String,
        description = json['description'] as String,
        website = json['website'] as String,
        social = json['social'] as String,
        decimals = json['decimals'] as String,
        cap = json['cap'] as String,
        supply = json['supply'] as String,
        holders = json['holders'] as int,
        fee = json['fee'] as String,
        owner = json['owner'] as String,
        metadata = json['metadata'] as String,
        hash = json['hash'] as String;

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
      'denom_suffix': denomSuffix,
      'name': name,
      'symbol': symbol,
      'icon': icon,
      'description': description,
      'website': website,
      'social': social,
      'decimals': decimals,
      'cap': cap,
      'supply': supply,
      'holders': holders,
      'fee': fee,
      'owner': owner,
      'metadata': metadata,
      'hash': hash,
    };
  }
}

class MsgMintIssueTx extends TxMsg {
  static String get interxName => 'mint-issue-tx';

  @override
  String get messageType => '/kira.layer2.MsgMintIssueTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgMintIssueTx';

  final String sender;
  final String denom;
  final String amount;
  final String receiver;

  MsgMintIssueTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        denom = json['denom'] as String,
        amount = json['amount'] as String,
        receiver = json['receiver'] as String;

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
      'denom': denom,
      'amount': amount,
      'receiver': receiver,
    };
  }
}

class MsgMintBurnTx extends TxMsg {
  static String get interxName => 'mint-burn-tx';

  @override
  String get messageType => '/kira.layer2.MsgMintBurnTx';

  @override
  String get signatureMessageType => 'kiraHub/MsgMintBurnTx';

  final String sender;
  final String denom;
  final String amount;

  MsgMintBurnTx.fromJson(Map<String, dynamic> json)
      : sender = json['sender'] as String,
        denom = json['denom'] as String,
        amount = json['amount'] as String;

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
      'denom': denom,
      'amount': amount,
    };
  }
}

