import 'package:kira_dashboard/infra/entities/proposals/proposal_details_entity.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';
import 'package:kira_dashboard/infra/repository/proposals_repository.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/models/proposal_details.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ProposalsService {
  final ProposalsRepository proposalsRepository = ProposalsRepository();

  Future<List<Proposal>> getPage(PaginatedRequest paginatedRequest) async {
    List<ProposalEntity> proposalEntities = await proposalsRepository.getPage(paginatedRequest);
    List<Proposal> proposalsList = proposalEntities.map(Proposal.fromEntity).toList();

    return proposalsList;
  }

  Future<ProposalDetails> getProposalDetails(String proposalId) async {
    ProposalDetailsEntity proposalDetailsEntity = await proposalsRepository.getProposalDetails(proposalId);
    ProposalDetails proposalDetails = ProposalDetails(
      proposal: Proposal.fromEntity(proposalDetailsEntity.proposal),
      votes: proposalDetailsEntity.votes.map(Vote.fromEntity).toList(),
    );
    return proposalDetails;
  }
}
