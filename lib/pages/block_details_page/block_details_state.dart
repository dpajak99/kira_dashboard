import 'package:kira_dashboard/models/block_details.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class BlockDetailsState extends PageState {
  final BlockDetails? blockDetails;

  const BlockDetailsState({
    this.blockDetails,
    required super.isLoading,
  });

  @override
  List<Object?> get props => <Object?>[super.isLoading, blockDetails];
}
