import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_details_entity.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';
import 'package:kira_dashboard/infra/repository/proposals_repository.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/models/proposal_details.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ProposalsService {
  final ProposalsRepository proposalsRepository = ProposalsRepository();

  Future<PaginatedListWrapper<Proposal>> getPage(PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<ProposalEntity> response = await proposalsRepository.getPage(paginatedRequest);

    List<Proposal> proposalsList = response.items.map((ProposalEntity e) => Proposal.fromEntity(e)).toList();

    return PaginatedListWrapper<Proposal>(items: proposalsList, total: response.total);
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
