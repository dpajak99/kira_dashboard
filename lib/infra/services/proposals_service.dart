import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';
import 'package:kira_dashboard/infra/repository/blocks_repository.dart';
import 'package:kira_dashboard/infra/repository/proposals_repository.dart';
import 'package:kira_dashboard/models/block.dart';
import 'package:kira_dashboard/models/proposal.dart';

class ProposalsService {
  final ProposalsRepository proposalsRepository = ProposalsRepository();

  Future<List<Proposal>> getAll() async {
    List<ProposalEntity> proposalEntities = await proposalsRepository.getAll();
    List<Proposal> proposalsList = proposalEntities.map((ProposalEntity proposal) => Proposal.fromEntity(proposal)).toList();

    return proposalsList;
  }
}