import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: PortfolioRoute.page,
          path: '/portfolio/:address',
          initial: true,
        )
      ];
}
