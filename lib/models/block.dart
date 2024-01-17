import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class Block {
  final String height;
  final String proposer;
  final String hash;
  final DateTime time;
  final String numTxs;

  Block({
    required this.height,
    required this.proposer,
    required this.hash,
    required this.time,
    required this.numTxs,
  });

  factory Block.fromEntity(BlockEntity entity) {
    return Block(
      height: entity.header.height,
      proposer: entity.header.proposerAddress,
      hash: entity.blockId.hash,
      time: DateTime.parse(entity.header.time),
      numTxs: entity.numTxs,
    );
  }
}
