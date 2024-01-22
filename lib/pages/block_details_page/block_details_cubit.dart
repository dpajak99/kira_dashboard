import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/blocks_service.dart';
import 'package:kira_dashboard/models/block_details.dart';
import 'package:kira_dashboard/pages/block_details_page/block_details_state.dart';

class BlockDetailsCubit extends Cubit<BlockDetailsState> {
  final BlocksService blocksService = BlocksService();
  final String blockHeight;

  BlockDetailsCubit({required this.blockHeight}) : super(const BlockDetailsState(isLoading: true)) {
    init();
  }

  Future<void> init() async {
      BlockDetails blockDetails = await blocksService.getDetails(blockHeight);
      emit(BlockDetailsState(isLoading: false, blockDetails: blockDetails));
  }
}