import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/staking_pool_dto.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class StakingPoolRepository extends ApiRepository {
  Future<StakingPoolDto> getByAddress(String address) async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get(
        '/api/kira/staking-pool',
        queryParameters: {
          'validatorAddress': address,
        },
      );
      StakingPoolDto stakingPoolDto = StakingPoolDto.fromJson(response.data!);
      return stakingPoolDto;
    } catch (e) {
      AppLogger().log(message: 'StakingPoolRepository');
      rethrow;
    }
  }
}
