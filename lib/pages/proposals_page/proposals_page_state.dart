import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class ProposalsPageState extends PageState {
  final List<Proposal> proposals;

  const ProposalsPageState({
    required super.isLoading,
    this.proposals = const <Proposal>[],
  });

  @override
  List<Object?> get props => <Object?>[proposals];
}
