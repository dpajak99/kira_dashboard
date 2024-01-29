import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/utils/router/guards/connection_guard.dart';
import 'package:kira_dashboard/utils/router/guards/splash_guard.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: SplashRoute.page,
        path: '/loading',
        guards: [SplashGuard()],
      ),
      AutoRoute(
        page: MenuWrapperRoute.page,
        initial: true,
        path: '/',
        guards: [ConnectionGuard()],
        children: [
          AutoRoute(
            page: PortfolioRoute.page,
            path: 'address/:address',
            usesPathAsKey: true,
          ),
          AutoRoute(
            page: ValidatorsRoute.page,
            initial: true,
            path: 'validators',
          ),
          AutoRoute(
            page: BlocksRoute.page,
            path: 'blocks',
          ),
          AutoRoute(
            page: ProposalsRoute.page,
            path: 'address',
          ),
          AutoRoute(
            page: BlockTransactionsRoute.page,
            path: 'transactions',
          ),
          AutoRoute(
            page: TransactionDetailsRoute.page,
            path: 'transaction/:hash',
            usesPathAsKey: true,
          ),
          AutoRoute(
            page: BlockDetailsRoute.page,
            path: 'blocks/:height',
            usesPathAsKey: true,
          ),
        ],
      ),
    ];
  }
}
