import 'package:kira_dashboard/models/dashboard_model.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class DashboardPageState extends PageState {
  final Dashboard? dashboard;

  const DashboardPageState({
    this.dashboard,
    required super.isLoading ,
  });

  @override
  List<Object?> get props => [dashboard];
}
