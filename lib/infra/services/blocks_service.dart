import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/repository/blocks_repository.dart';
import 'package:kira_dashboard/models/block.dart';

class BlocksService {
  final BlocksRepository blocksRepository = BlocksRepository();

  Future<List<Block>> getAll() async {
    List<BlockEntity> blocks = await blocksRepository.getAll();
    List<Block> blockList = blocks.map((BlockEntity block) => Block.fromEntity(block)).toList();

    return blockList;
  }
}