import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: MenuWrapperRoute.page,
        initial: true,
        path: '/',
        children: [
          AutoRoute(
            page: PortfolioRoute.page,
            path: 'address/:address',
            initial: true,
            usesPathAsKey: true,
          ),
          AutoRoute(
            page: ValidatorsRoute.page,
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
            path: 'blocks/:block',
            usesPathAsKey: true,
          ),
        ],
      ),
    ];
  }
}
