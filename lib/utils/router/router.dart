import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/utils/router/guards/connection_guard.dart';
import 'package:kira_dashboard/utils/router/guards/splash_guard.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.custom(
        durationInMilliseconds: 100,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: SplashRoute.page,
        path: '/loading',
        usesPathAsKey: true,
        guards: [SplashGuard()],
      ),
      AutoRoute(
        page: MenuWrapperRoute.page,
        initial: true,
        path: '/',
        usesPathAsKey: true,
        guards: [ConnectionGuard()],
        children: [
          AutoRoute(
            page: DashboardRoute.page,
            initial: true,
            usesPathAsKey: true,
            path: 'dashboard',
          ),
          AutoRoute(
            page: PortfolioRoute.page,
            usesPathAsKey: true,
            path: 'address/:address',
          ),
          AutoRoute(
            page: ValidatorsRoute.page,
            usesPathAsKey: true,
            path: 'validators',
          ),
          AutoRoute(
            page: BlocksRoute.page,
            usesPathAsKey: true,
            path: 'blocks',
          ),
          AutoRoute(
            page: ProposalsRoute.page,
            usesPathAsKey: true,
            path: 'proposals',
          ),
          AutoRoute(
            page: ProposalDetailsRoute.page,
            usesPathAsKey: true,
            path: 'proposal/:proposalId',
          ),
          AutoRoute(
            page: BlockTransactionsRoute.page,
            usesPathAsKey: true,
            path: 'transactions',
          ),
          AutoRoute(
            page: TransactionDetailsRoute.page,
            usesPathAsKey: true,
            path: 'transaction/:hash',
          ),
          AutoRoute(
            page: BlockDetailsRoute.page,
            usesPathAsKey: true,
            path: 'blocks/:height',
          ),
        ],
      ),
    ];
  }
}
