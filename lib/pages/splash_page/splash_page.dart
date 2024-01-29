import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_state.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  final PageRouteInfo? routeInfo;

  const SplashPage({super.key, this.routeInfo});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkListCubit, NetworkListState>(
      bloc: getIt<NetworkListCubit>(),
      listener: (BuildContext context, NetworkListState state) {
        if (state.isConnected && routeInfo != null) {
          AutoRouter.of(context).replace(routeInfo!);
        } else if (state.isConnected) {
          AutoRouter.of(context).replace(const MenuWrapperRoute());
        }
      },
      builder: (BuildContext context, NetworkListState state) {
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isConnecting)
                  Text('Connecting to: ${state.currentNetwork?.name} (${state.currentNetwork?.interxUrl.toString()})'),
              ],
            ),
          ),
        );
      },
    );
  }
}
