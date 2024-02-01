import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/late_value_listenable_builder.dart';
import 'package:kira_dashboard/widgets/network_button.dart';
import 'package:kira_dashboard/widgets/wallet_button.dart';

@RoutePage()
class MenuWrapperPage extends StatefulWidget {
  const MenuWrapperPage({super.key});

  @override
  MenuWrapperPageState createState() => MenuWrapperPageState();
}

class MenuWrapperPageState extends State<MenuWrapperPage> with SingleTickerProviderStateMixin {
  late final NotifierRouteObserver notifierRouteObserver;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool collapsed = false;

  @override
  void initState() {
    super.initState();
    notifierRouteObserver = NotifierRouteObserver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: _Drawer(notifierRouteObserver: notifierRouteObserver),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 900)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: LateValueListenableBuilder(
                valueListenable: notifierRouteObserver.currentRoute,
                builder: (BuildContext context, String currentRouteName, _) {
                  return Column(
                    children: [
                      IconButton(
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                        icon: const Icon(Icons.menu),
                      ),
                      const SizedBox(height: 24),
                      _SmallNavigationButton(
                        route: const ValidatorsRoute(),
                        current: currentRouteName == ValidatorsRoute.name,
                        icon: AppIcons.shield,
                      ),
                      _SmallNavigationButton(
                        route: const BlocksRoute(),
                        current: currentRouteName == BlocksRoute.name,
                        icon: AppIcons.block,
                      ),
                      _SmallNavigationButton(
                        route: BlockTransactionsRoute(),
                        current: currentRouteName == BlockTransactionsRoute.name,
                        icon: AppIcons.transactions,
                      ),
                      _SmallNavigationButton(
                        route: const ProposalsRoute(),
                        current: currentRouteName == ProposalsRoute.name,
                        icon: AppIcons.proposals,
                      ),
                    ],
                  );
                },
              ),
            ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minWidth: 450),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1300),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (MediaQuery.of(context).size.width <= 900)
                            Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: IconButton(
                                onPressed: () => scaffoldKey.currentState?.openDrawer(),
                                icon: const Icon(Icons.menu),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SvgPicture.asset('logo_light.svg', height: MediaQuery.of(context).size.width > 900 ? 30 : 24),
                          ),
                          const SizedBox(width: 40),
                          if (MediaQuery.of(context).size.width > 900) ...<Widget>[
                            Container(
                              constraints: const BoxConstraints(maxWidth: 300, minWidth: 100),
                              decoration: const BoxDecoration(
                                color: Color(0xff11141c),
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Color(0xff47546d),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Search for address",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff47546d),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const NetworkButton(),
                            const SizedBox(width: 16),
                            const WalletButton(),
                          ] else ...<Widget>[
                            const Spacer(),
                            const Row(
                              children: [
                                NetworkButton(),
                                WalletButton(small: true),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AutoRouter(
                    navigatorObservers: () => <NavigatorObserver>[
                      notifierRouteObserver,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotifierRouteObserver extends NavigatorObserver {
  final ValueNotifier<String> currentRoute = ValueNotifier<String>('');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute.value = route.data?.name ?? '';
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    currentRoute.value = previousRoute?.data?.name ?? '';
  }
}

class _Drawer extends StatelessWidget {
  final NotifierRouteObserver notifierRouteObserver;

  const _Drawer({required this.notifierRouteObserver});

  @override
  Widget build(BuildContext context) {
    return LateValueListenableBuilder(
      valueListenable: notifierRouteObserver.currentRoute,
      builder: (BuildContext context, String currentRouteName, _) {
        return Drawer(
          width: 250,
          child: Container(
            color: const Color(0xff0e131f),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset('logo_light.svg', height: 30),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.chevron_left),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _LargeNavigationButton(
                  route: const ValidatorsRoute(),
                  title: 'Validators',
                  icon: AppIcons.shield,
                  current: currentRouteName == ValidatorsRoute.name,
                ),
                _LargeNavigationButton(
                  route: const BlocksRoute(),
                  title: 'Blocks',
                  icon: AppIcons.block,
                  current: currentRouteName == BlocksRoute.name,
                ),
                _LargeNavigationButton(
                  route: BlockTransactionsRoute(),
                  title: 'Transactions',
                  icon: AppIcons.transactions,
                  current: currentRouteName == BlockTransactionsRoute.name,
                ),
                _LargeNavigationButton(
                  route: const ProposalsRoute(),
                  title: 'Proposals',
                  icon: AppIcons.proposals,
                  current: currentRouteName == ProposalsRoute.name,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LargeNavigationButton extends StatelessWidget {
  final IconData icon;
  final bool current;
  final String title;
  final PageRouteInfo route;

  const _LargeNavigationButton({
    required this.icon,
    required this.current,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
        onPressed: current ? () {} : () => AutoRouter.of(context).push(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: current ? const Color(0xff1a1f2e) : Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: current ? const Color(0xff4888f0) : Colors.white.withOpacity(0.5),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: current ? const Color(0xff4888f0) : Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallNavigationButton extends StatelessWidget {
  final IconData icon;
  final bool current;
  final PageRouteInfo route;

  const _SmallNavigationButton({
    required this.icon,
    required this.current,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: IconButton(
        onPressed: current ? () {} : () => AutoRouter.of(context).push(route),
        icon: Icon(
          icon,
          color: current ? const Color(0xff4888f0) : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
