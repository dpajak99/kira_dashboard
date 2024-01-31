import 'package:kira_dashboard/models/proposal_details.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class ProposalDetailsPageState extends PageState {
  final ProposalDetails? proposalDetails;

  const ProposalDetailsPageState({
    this.proposalDetails,
    required super.isLoading,
  });

  @override
  List<Object?> get props => [proposalDetails, isLoading];
}
