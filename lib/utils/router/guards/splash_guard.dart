import 'package:auto_route/auto_route.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';

class SplashGuard extends AutoRouteGuard {
  final NetworkListCubit networkListCubit = getIt<NetworkListCubit>();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    await networkListCubit.initializationCompleter.future;
    if(networkListCubit.state.isConnecting) {
      resolver.next(true);
    } else {
      resolver.next(false);
    }
  }
}