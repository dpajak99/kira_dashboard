import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_dialog.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';

class NetworkButton extends StatelessWidget {
  final bool small;

  const NetworkButton({
    super.key,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      bloc: getIt<NetworkCubit>(),
      builder: (BuildContext context, NetworkState state) {
        NetworkStatus currentNetwork = state.currentNetwork!;

        if (small) {
          return IconButton(
            onPressed: () => DialogRouter().navigate(const NetworkDialog()),
            icon: Icon(
              Icons.network_wifi,
              color: switch (currentNetwork.status) {
                NetworkStatusType.online => CustomColors.green,
                NetworkStatusType.unhealthy => CustomColors.yellow,
                NetworkStatusType.offline => CustomColors.red,
                NetworkStatusType.connecting => CustomColors.secondary,
              },
            ),
          );
        }

        return InkWell(
          onTap: () => DialogRouter().navigate(const NetworkDialog()),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleIcon(
                  size: 20,
                  proxyEnabled: currentNetwork.proxyEnabled,
                  color: switch (currentNetwork.status) {
                    NetworkStatusType.online => CustomColors.green,
                    NetworkStatusType.unhealthy => CustomColors.yellow,
                    NetworkStatusType.offline => CustomColors.red,
                    NetworkStatusType.connecting => CustomColors.secondary,
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  currentNetwork.name ?? currentNetwork.details?.chainId ?? currentNetwork.interxUrl.host,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
