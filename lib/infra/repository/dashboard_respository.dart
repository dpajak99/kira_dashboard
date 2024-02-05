import 'package:dio/dio.dart';
import 'package:kira_dashboard/infra/entities/dashboard_dto.dart';
import 'package:kira_dashboard/infra/repository/api_repository.dart';
import 'package:kira_dashboard/utils/logger/app_logger.dart';

class DashboardRepository extends ApiRepository {
  Future<DashboardDto> getDashboard() async {
    try {
      Response<Map<String, dynamic>> response = await httpClient.get('/api/dashboard');
      DashboardDto dashboardDto = DashboardDto.fromJson(response.data!);
      return dashboardDto;
    } catch (e) {
      AppLogger().log(message: 'DashboardRepository');
      rethrow;
    }
  }
}
