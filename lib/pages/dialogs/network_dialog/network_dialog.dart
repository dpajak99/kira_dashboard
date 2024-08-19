import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/utils/network_utils.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class NetworkDialog extends DialogContentWidget {
  const NetworkDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NetworkDialog();
}

class _NetworkDialog extends State<NetworkDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<NetworkCubit, NetworkState>(
      bloc: getIt<NetworkCubit>(),
      builder: (BuildContext context, NetworkState state) {
        return CustomDialog(
          title: 'Select network',
          width: 420,
          child: Column(
            children: [
              if (state.currentNetwork != null) ...<Widget>[
                const Text('Current network'),
                const SizedBox(height: 8),
                ConnectedNetworkTile(networkStatus: state.currentNetwork!),
                const SizedBox(height: 32),
              ],
              const Text('Available networks'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 8),
                decoration: const BoxDecoration(
                  color: CustomColors.dialogContainer,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    ...state.availableNetworks.map((NetworkStatus e) {
                      return AvailableNetworkTile(
                        networkStatus: e,
                        onTap: () {
                          getIt<NetworkCubit>().connect(e);
                        },
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: CustomColors.dialogContainer,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
                        cursorColor: CustomColors.white,
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Custom address',
                          hintStyle: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SimpleTextButton(
                      text: 'Add',
                      onTap: () {
                        try {
                          getIt<NetworkCubit>().addCustomNetwork(NetworkTemplate(
                            name: 'Custom',
                            custom: true,
                            interxUrl: NetworkUtils.formatUrl(controller.text),
                          ));
                        } finally {
                          controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ConnectedNetworkTile extends StatelessWidget {
  final NetworkStatus networkStatus;

  const ConnectedNetworkTile({
    super.key,
    required this.networkStatus,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    NetworkDetails? details = networkStatus.details;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: CustomColors.dialogContainer,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: CircleIcon(
              size: 20,
              proxyEnabled: networkStatus.proxyEnabled,
              color: switch (networkStatus.status) {
                NetworkStatusType.online => CustomColors.green,
                NetworkStatusType.unhealthy => CustomColors.yellow,
                NetworkStatusType.offline => CustomColors.red,
                NetworkStatusType.connecting => CustomColors.secondary,
              },
            ),
            title: Text(
              networkStatus.name ?? 'unknown',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
            ),
            subtitle: Text(
              networkStatus.interxUrl.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelMedium!.copyWith(color: CustomColors.secondary),
            ),
            trailing: Text(
              'Connected',
              style: textTheme.labelMedium!.copyWith(
                color: switch (networkStatus.status) {
                  NetworkStatusType.online => CustomColors.green,
                  NetworkStatusType.unhealthy => CustomColors.yellow,
                  NetworkStatusType.offline => CustomColors.red,
                  NetworkStatusType.connecting => CustomColors.secondary,
                },
              ),
            ),
          ),
          const Divider(color: CustomColors.divider),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chain', style: textTheme.labelMedium!.copyWith(color: CustomColors.secondary)),
                    Text(details?.chainId ?? '---', style: textTheme.labelMedium!.copyWith(color: CustomColors.white)),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Block time', style: textTheme.labelMedium!.copyWith(color: CustomColors.secondary)),
                    Text(details?.blockDateTime != null ? DateFormat('d MMM y, HH:mm').format(details!.blockDateTime) : '---',
                        style: textTheme.labelMedium!.copyWith(color: CustomColors.white)),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Block height', style: textTheme.labelMedium!.copyWith(color: CustomColors.secondary)),
                    Text(details?.block.toString() ?? '---', style: textTheme.labelMedium!.copyWith(color: CustomColors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AvailableNetworkTile extends StatelessWidget {
  final NetworkStatus networkStatus;
  final VoidCallback onTap;

  const AvailableNetworkTile({
    super.key,
    required this.networkStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.only(right: networkStatus.custom ? 0 : 8),
      dense: true,
      leading: CircleIcon(
        size: 20,
        proxyEnabled: networkStatus.proxyEnabled,
        color: switch (networkStatus.status) {
          NetworkStatusType.online => Colors.green,
          NetworkStatusType.unhealthy => Colors.yellow,
          NetworkStatusType.offline => Colors.red,
          NetworkStatusType.connecting => CustomColors.secondary,
        },
      ),
      title: Text(
        networkStatus.name ?? 'unknown',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: CustomColors.white),
      ),
      subtitle: Text(
        networkStatus.interxUrl.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.labelMedium!.copyWith(color: CustomColors.secondary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (networkStatus.status == NetworkStatusType.online)
            SimpleTextButton(
              text: 'Connect',
              onTap: onTap,
            ),
          if (networkStatus.custom) ...<Widget>[
            const SizedBox(width: 8),
            IconButton(
              onPressed: (){
                getIt<NetworkCubit>().removeCustomNetwork(networkStatus.interxUrl);
              },
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                AppIcons.cancel,
                color: CustomColors.secondary,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  final double size;
  final Color color;
  final bool proxyEnabled;

  const CircleIcon({
    super.key,
    required this.size,
    required this.color,
    required this.proxyEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.circle_outlined,
                size: size,
                color: color.withOpacity(0.5),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.circle,
                size: size / 2,
                color: color,
                shadows: const [
                  BoxShadow(
                    color: Colors.white30,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          if (proxyEnabled)
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: size / 2,
                height: size / 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: Icon(
                          Icons.cloud,
                          size: size / 1.7,
                          color: color,
                          shadows: List.generate(
                            10,
                            (index) => Shadow(
                              blurRadius: 2,
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
