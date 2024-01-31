import 'package:kira_dashboard/infra/services/proposals_service.dart';
import 'package:kira_dashboard/models/proposal_details.dart';
import 'package:kira_dashboard/pages/proposal_details_page/proposal_details_page_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class ProposalDetailsPageCubit extends RefreshablePageCubit<ProposalDetailsPageState> {
  final ProposalsService proposalsService = ProposalsService();

  final String proposalId;

  ProposalDetailsPageCubit({
    required this.proposalId,
  }) : super(const ProposalDetailsPageState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const ProposalDetailsPageState(isLoading: true));
    ProposalDetails proposalDetails = await proposalsService.getProposalDetails(proposalId);
    emit(ProposalDetailsPageState(proposalDetails: proposalDetails, isLoading: false));
  }
}
