import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class BlocksPageState extends PageState {
  final List<Block> blocks;

  const BlocksPageState({
    required super.isLoading,
    this.blocks = const <Block>[],
  });

  @override
  List<Object?> get props => <Object?>[blocks];
}
