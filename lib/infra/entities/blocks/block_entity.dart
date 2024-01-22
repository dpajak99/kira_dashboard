import 'package:equatable/equatable.dart';

class Parts extends Equatable {
  final String hash;
  final int total;

  Parts.fromJson(Map<String, dynamic> json)
      : hash = json['hash'],
        total = json['total'];

  @override
  List<Object?> get props => <Object?>[hash, total];
}

class BlockId extends Equatable {
  final String hash;
  final Parts parts;

  BlockId.fromJson(Map<String, dynamic> json)
      : hash = json['hash'],
        parts = Parts.fromJson(json['parts']);

  @override
  List<Object?> get props => <Object?>[hash, parts];
}

class Version extends Equatable {
  final String block;

  Version.fromJson(Map<String, dynamic> json)
      : block = json['block'];

  @override
  List<Object?> get props => <Object?>[block];
}

class Header extends Equatable {
  final String appHash;
  final String chainId;
  final String consensusHash;
  final String dataHash;
  final String evidenceHash;
  final String height;
  final BlockId lastBlockId;
  final String lastCommitHash;
  final String lastResultsHash;
  final String nextValidatorsHash;
  final String proposerAddress;
  final String time;
  final String validatorsHash;
  final Version version;

  Header.fromJson(Map<String, dynamic> json)
      : appHash = json['app_hash'],
        chainId = json['chain_id'],
        consensusHash = json['consensus_hash'],
        dataHash = json['data_hash'],
        evidenceHash = json['evidence_hash'],
        height = json['height'],
        lastBlockId = BlockId.fromJson(json['last_block_id']),
        lastCommitHash = json['last_commit_hash'],
        lastResultsHash = json['last_results_hash'],
        nextValidatorsHash = json['next_validators_hash'],
        proposerAddress = json['proposer_address'],
        time = json['time'],
        validatorsHash = json['validators_hash'],
        version = Version.fromJson(json['version']);

  @override
  List<Object?> get props => <Object?>[appHash, chainId, consensusHash, dataHash, evidenceHash, height, lastBlockId, lastCommitHash, lastResultsHash, nextValidatorsHash, proposerAddress, time, validatorsHash, version];
}

class BlockEntity extends Equatable {
  final BlockId blockId;
  final String blockSize;
  final Header header;
  final String numTxs;

  BlockEntity.fromJson(Map<String, dynamic> json)
      : blockId = BlockId.fromJson(json['block_id']),
        blockSize = json['block_size'],
        header = Header.fromJson(json['header']),
        numTxs = json['num_txs'];

  @override
  List<Object?> get props => <Object?>[blockId, blockSize, header, numTxs];
}

class Commit extends Equatable {
  final BlockId blockId;
  final String height;
  final int round;
  final List<dynamic> signatures;

  Commit.fromJson(Map<String, dynamic> json)
      : blockId = BlockId.fromJson(json['block_id']),
        height = json['height'],
        round = json['round'],
        signatures = json['signatures'];

  @override
  List<Object?> get props => <Object?>[blockId, height, round, signatures];

}

class BlockData extends Equatable {
  final dynamic data;
  final dynamic evidence;
  final Header header;
  final Commit lastCommit;

  BlockData.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        evidence = json['evidence'],
        header = Header.fromJson(json['header']),
        lastCommit = Commit.fromJson(json['last_commit']);

  @override
  List<Object?> get props => <Object?>[data, evidence, header, lastCommit];
}

class BlockDetailsEntity extends Equatable {
  final BlockData block;
  final BlockId blockId;

  BlockDetailsEntity.fromJson(Map<String, dynamic> json)
      : block = BlockData.fromJson(json['block']),
        blockId = BlockId.fromJson(json['block_id']);

  @override
  List<Object?> get props => <Object?>[block, blockId];
}