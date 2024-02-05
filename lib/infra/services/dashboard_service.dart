import 'package:kira_dashboard/infra/entities/dashboard_dto.dart';
import 'package:kira_dashboard/infra/repository/dashboard_respository.dart';
import 'package:kira_dashboard/models/dashboard_model.dart';

class DashboardService {
  final DashboardRepository dashboardRepository = DashboardRepository();

  Future<Dashboard> getDashboard() async {
    DashboardDto dashboardDto = await dashboardRepository.getDashboard();
    return Dashboard.fromDto(dashboardDto);
  }
}