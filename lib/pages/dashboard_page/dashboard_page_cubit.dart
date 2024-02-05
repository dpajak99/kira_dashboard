import 'package:kira_dashboard/infra/services/dashboard_service.dart';
import 'package:kira_dashboard/models/dashboard_model.dart';
import 'package:kira_dashboard/pages/dashboard_page/dashboard_page_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class DashboardPageCubit extends RefreshablePageCubit<DashboardPageState> {
  final DashboardService dashboardService = DashboardService();

  DashboardPageCubit() : super(const DashboardPageState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const DashboardPageState(isLoading: true));
    Dashboard dashboard = await dashboardService.getDashboard();
    emit(DashboardPageState(isLoading: false, dashboard: dashboard));
  }
}