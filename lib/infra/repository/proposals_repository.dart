import 'package:dio/dio.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/infra/entities/blocks/block_entity.dart';
import 'package:kira_dashboard/infra/entities/blocks/query_blocks_response.dart';
import 'package:kira_dashboard/infra/entities/proposals/proposal_entity.dart';
import 'package:kira_dashboard/infra/entities/proposals/query_proposals_response.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class ProposalsRepository {
  final Dio httpClient = getIt<NetworkProvider>().httpClient;

  Future<List<ProposalEntity>> getAll() async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/kira/gov/proposals');
      QueryProposalsResponse queryProposalsResponse = QueryProposalsResponse.fromJson(response.data!);

      return queryProposalsResponse.proposals;
    } catch (e) {
      AppLogger().log(message: 'ProposalsRepository');
      rethrow;
    }
  }
}
