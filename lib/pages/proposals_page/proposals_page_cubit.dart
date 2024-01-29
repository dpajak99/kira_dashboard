import 'package:kira_dashboard/infra/services/proposals_service.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/pages/proposals_page/proposals_page_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ProposalsPageCubit extends ListCubit<ProposalsPageState> {
  final ProposalsService proposalsService = ProposalsService();

  ProposalsPageCubit() : super(const ProposalsPageState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const ProposalsPageState(isLoading: true));

    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<Proposal> proposals = await proposalsService.getPage(paginatedRequest);

    emit(ProposalsPageState(
      isLoading: false,
      proposals: proposals,
    ));
  }
}
