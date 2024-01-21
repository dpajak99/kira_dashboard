import 'package:equatable/equatable.dart';

class PubKey extends Equatable {
  final String type;
  final String value;

  PubKey.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        value = json['value'] as String;

  @override
  List<Object?> get props => <Object?>[type, value];

}

class Node extends Equatable {
  final String nodeType;
  final String sentryNodeId;
  final String snapshotNodeId;
  final String validatorNodeId;
  final String seedNodeId;

  Node.fromJson(Map<String, dynamic> json)
      : nodeType = json['node_type'] as String,
        sentryNodeId = json['sentry_node_id'] as String,
        snapshotNodeId = json['snapshot_node_id'] as String,
        validatorNodeId = json['validator_node_id'] as String,
        seedNodeId = json['seed_node_id'] as String;

  @override
  List<Object?> get props => <Object?>[nodeType, sentryNodeId, snapshotNodeId, validatorNodeId, seedNodeId];
}

class InterxInfo extends Equatable {
  final PubKey pubKey;
  final String moniker;
  final String kiraAddr;
  final String kiraPubKey;
  final String faucetAddr;
  final String genesisChecksum;
  final String chainId;
  final String version;
  final String latestBlockHeight;
  final bool catchingUp;
  final Node node;

  InterxInfo.fromJson(Map<String, dynamic> json)
      : pubKey = PubKey.fromJson(json['pub_key']),
        moniker = json['moniker'] as String,
        kiraAddr = json['kira_addr'] as String,
        kiraPubKey = json['kira_pub_key'] as String,
        faucetAddr = json['faucet_addr'] as String,
        genesisChecksum = json['genesis_checksum'] as String,
        chainId = json['chain_id'] as String,
        version = json['version'] as String,
        latestBlockHeight = json['latest_block_height'] as String,
        catchingUp = json['catching_up'] as bool,
        node = Node.fromJson(json['node']);

  @override
  List<Object?> get props => <Object?>[pubKey, moniker, kiraAddr, kiraPubKey, faucetAddr, genesisChecksum, chainId, version, latestBlockHeight, catchingUp, node];
}

class ProtocolVersion extends Equatable {
  final String p2p;
  final String block;
  final String app;

  ProtocolVersion.fromJson(Map<String, dynamic> json)
      : p2p = json['p2p'] as String,
        block = json['block'] as String,
        app = json['app'] as String;

  @override
  List<Object?> get props => <Object?>[p2p, block, app];
}

class Other extends Equatable {
  final String txIndex;
  final String rpcAddress;

  Other.fromJson(Map<String, dynamic> json)
      : txIndex = json['tx_index'] as String,
        rpcAddress = json['rpc_address'] as String;

  @override
  List<Object?> get props => <Object?>[txIndex, rpcAddress];
}

class NodeInfo extends Equatable {
  final ProtocolVersion protocolVersion;
  final String id;
  final String listenAddr;
  final String network;
  final String version;
  final String channels;
  final String moniker;
  final Other other;

  NodeInfo.fromJson(Map<String, dynamic> json)
      : protocolVersion = ProtocolVersion.fromJson(json['protocol_version']),
        id = json['id'] as String,
        listenAddr = json['listen_addr'] as String,
        network = json['network'] as String,
        version = json['version'] as String,
        channels = json['channels'] as String,
        moniker = json['moniker'] as String,
        other = Other.fromJson(json['other']);

  @override
  List<Object?> get props => <Object?>[protocolVersion, id, listenAddr, network, version, channels, moniker, other];
}

class SyncInfo extends Equatable {
  final String latestBlockHash;
  final String latestAppHash;
  final String latestBlockHeight;
  final String latestBlockTime;
  final String earliestBlockHash;
  final String earliestAppHash;
  final String earliestBlockHeight;
  final String earliestBlockTime;

  SyncInfo.fromJson(Map<String, dynamic> json)
      : latestBlockHash = json['latest_block_hash'] as String,
        latestAppHash = json['latest_app_hash'] as String,
        latestBlockHeight = json['latest_block_height'] as String,
        latestBlockTime = json['latest_block_time'] as String,
        earliestBlockHash = json['earliest_block_hash'] as String,
        earliestAppHash = json['earliest_app_hash'] as String,
        earliestBlockHeight = json['earliest_block_height'] as String,
        earliestBlockTime = json['earliest_block_time'] as String;

  @override
  List<Object?> get props => <Object?>[latestBlockHash, latestAppHash, latestBlockHeight, latestBlockTime, earliestBlockHash, earliestAppHash, earliestBlockHeight, earliestBlockTime];
}

class ValidatorInfo extends Equatable {
  final String address;
  final PubKey pubKey;
  final String votingPower;

  ValidatorInfo.fromJson(Map<String, dynamic> json)
      : address = json['address'] as String,
        pubKey = PubKey.fromJson(json['pub_key']),
        votingPower = json['voting_power'] as String;

  @override
  List<Object?> get props => <Object?>[address, pubKey, votingPower];
}

class NetworkStatusEntity extends Equatable {
  final String id;
  final InterxInfo interxInfo;
  final NodeInfo nodeInfo;
  final SyncInfo syncInfo;
  final ValidatorInfo validatorInfo;

  NetworkStatusEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        interxInfo = InterxInfo.fromJson(json['interx_info']),
        nodeInfo = NodeInfo.fromJson(json['node_info']),
        syncInfo = SyncInfo.fromJson(json['sync_info']),
        validatorInfo = ValidatorInfo.fromJson(json['validator_info']);

  @override
  List<Object?> get props => <Object?>[id, interxInfo, nodeInfo, syncInfo, validatorInfo];
}