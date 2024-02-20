import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

class ConnectionGuard extends AutoRouteGuard {
  final NetworkCubit networkCubit = getIt<NetworkCubit>();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    print('Guard');
    if (networkCubit.state.isConnected) {
      print('Connected');
      resolver.next(true);
    } else {
      print('Not connected');
      router.push(SplashRoute(routeInfo: PageRouteInfo.fromMatch(resolver.route)));
    }
  }
}
