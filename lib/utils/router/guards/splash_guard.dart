import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';

class SplashGuard extends AutoRouteGuard {
  final NetworkCubit networkCubit = getIt<NetworkCubit>();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if(networkCubit.state.isConnected) {
      resolver.next(false);
    } else {
      resolver.next(true);
    }
  }
}