import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';
import 'package:kira_dashboard/infra/entities/proposals/query_proposals_response.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ProposalsRepository extends ApiRepository {
  Future<List<ProposalEntity>> getPage(PaginatedRequest paginatedRequest) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/gov/proposals',
        queryParameters: paginatedRequest.toJson(),
      );
      QueryProposalsResponse queryProposalsResponse = QueryProposalsResponse.fromJson(response.data!);

      return queryProposalsResponse.proposals;
    } catch (e) {
      AppLogger().log(message: 'ProposalsRepository');
      rethrow;
    }
  }
}
