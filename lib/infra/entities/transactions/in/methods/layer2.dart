import 'package:kira_dashboard/infra/entities/balances/coin_entity.dart';
import 'package:kira_dashboard/infra/entities/transactions/in/types.dart';

class MsgCreateDappProposal extends TxMsg {
  String get name => 'create-dapp-proposal';

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
}

class MsgBondDappProposal extends TxMsg {
  String get name => 'bond-dapp-proposal';

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
}

class MsgReclaimDappBondProposal extends TxMsg {
  String get name => 'reclaim-dapp-bond-proposal';

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
}

class MsgJoinDappVerifierWithBond extends TxMsg {
  String get name => 'join-dapp-verifier-with-bond';

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
}

class MsgExitDapp extends TxMsg {
  String get name => 'exit-dapp';

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
}

class MsgRedeemDappPoolTx extends TxMsg {
  String get name => 'redeem-dapp-pool-tx';

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
}

class MsgSwapDappPoolTx extends TxMsg {
  String get name => 'swap-dapp-pool-tx';

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
}

class MsgConvertDappPoolTx extends TxMsg {
  String get name => 'convert-dapp-pool-tx';

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
}

class MsgPauseDappTx extends TxMsg {
  String get name => 'pause-dapp-tx';

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
}

class MsgUnPauseDappTx extends TxMsg {
  String get name => 'unpause-dapp-tx';

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
}

class MsgReactivateDappTx extends TxMsg {
  String get name => 'reactivate-dapp-tx';

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
}

class MsgExecuteDappTx extends TxMsg {
  String get name => 'execute-dapp-tx';

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
}

class MsgDenounceLeaderTx extends TxMsg {
  String get name => 'denounce-leader-tx';

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
}

class MsgTransitionDappTx extends TxMsg {
  String get name => 'transition-dapp-tx';

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
}

class MsgApproveDappTransitionTx extends TxMsg {
  String get name => 'approve-dapp-transition-tx';

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
}

class MsgRejectDappTransitionTx extends TxMsg {
  String get name => 'reject-dapp-transition-tx';

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
}

class MsgTransferDappTx extends TxMsg {
  String get name => 'transfer-dapp-tx';

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
}

class MsgAckTransferDappTx extends TxMsg {
  String get name => 'ack-transfer-dapp-tx';

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
}

class MsgMintCreateFtTx extends TxMsg {
  String get _name => 'mint-create-ft-tx';

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
}

class MsgMintCreateNftTx extends TxMsg {
  String get _name => 'mint-create-nft-tx';

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
}

class MsgMintIssueTx extends TxMsg {
  String get name => 'mint-issue-tx';

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
}

class MsgMintBurnTx extends TxMsg {
  String get name => 'mint-burn-tx';

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
}

