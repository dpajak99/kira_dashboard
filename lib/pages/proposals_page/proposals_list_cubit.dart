import 'package:kira_dashboard/infra/services/proposals_service.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ProposalsListCubit extends PaginatedListCubit<Proposal> {
  final ProposalsService proposalsService = ProposalsService();

  ProposalsListCubit() : super(const PaginatedListState.loading());

  @override
  Future<PaginatedListWrapper<Proposal>> getPage(PaginatedRequest paginatedRequest) {
    return proposalsService.getPage(paginatedRequest);
  }
}
