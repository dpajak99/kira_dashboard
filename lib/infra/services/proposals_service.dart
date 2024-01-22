import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';
import 'package:kira_dashboard/infra/repository/proposals_repository.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ProposalsService {
  final ProposalsRepository proposalsRepository = ProposalsRepository();

  Future<List<Proposal>> getPage(PaginatedRequest paginatedRequest) async {
    List<ProposalEntity> proposalEntities = await proposalsRepository.getPage(paginatedRequest);
    List<Proposal> proposalsList = proposalEntities.map((ProposalEntity proposal) => Proposal.fromEntity(proposal)).toList();

    return proposalsList;
  }
}