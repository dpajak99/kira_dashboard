import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/config/app_icons.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/notification_box.dart';

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

    return BlocBuilder<NetworkListCubit, NetworkListState>(
      bloc: getIt<NetworkListCubit>(),
      builder: (BuildContext context, NetworkListState state) {
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
                  color: Color(0xff0a0d15),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    ...state.availableNetworks.map((NetworkStatus e) {
                      return AvailableNetworkTile(networkStatus: e);
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xff0a0d15),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
                        cursorColor: const Color(0xfffbfbfb),
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Custom address',
                          hintStyle: textTheme.bodyMedium!.copyWith(color: const Color(0xff3e4c63)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconTextButton(
                      text: 'Add',
                      highlightColor: const Color(0xfffbfbfb),
                      style: textTheme.bodyMedium!.copyWith(color: const Color(0xff4888f0)),
                      onTap: () {
                        getIt<NetworkListCubit>().addCustomNetwork(NetworkTemplate(
                          name: 'Custom',
                          custom: true,
                          interxUrl: Uri.parse(controller.text),
                        ));
                        controller.clear();
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
        color: Color(0xff0a0d15),
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
                NetworkStatusType.online => Colors.green,
                NetworkStatusType.unhealthy => Colors.yellow,
                NetworkStatusType.offline => Colors.red,
                NetworkStatusType.connecting => const Color(0xff6c86ad),
              },
            ),
            title: Text(
              networkStatus.name ?? 'unknown',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
            ),
            subtitle: Text(
              networkStatus.interxUrl.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
            ),
            trailing: Text(
              'Connected',
              style: textTheme.labelMedium!.copyWith(
                color: switch (networkStatus.status) {
                  NetworkStatusType.online => Colors.green,
                  NetworkStatusType.unhealthy => Colors.yellow,
                  NetworkStatusType.offline => Colors.red,
                  NetworkStatusType.connecting => const Color(0xff6c86ad),
                },
              ),
            ),
          ),
          const Divider(color: Color(0xff222b3a)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chain', style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad))),
                    Text(details?.chainId ?? '---', style: textTheme.labelMedium!.copyWith(color: const Color(0xfffbfbfb))),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Block time', style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad))),
                    Text(details?.blockDateTime != null ? DateFormat('d MMM y, HH:mm').format(details!.blockDateTime) : '---',
                        style: textTheme.labelMedium!.copyWith(color: const Color(0xfffbfbfb))),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Block height', style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad))),
                    Text(details?.block.toString() ?? '---', style: textTheme.labelMedium!.copyWith(color: const Color(0xfffbfbfb))),
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

  const AvailableNetworkTile({
    super.key,
    required this.networkStatus,
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
          NetworkStatusType.connecting => const Color(0xff6c86ad),
        },
      ),
      title: Text(
        networkStatus.name ?? 'unknown',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: const Color(0xfffbfbfb)),
      ),
      subtitle: Text(
        networkStatus.interxUrl.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.labelMedium!.copyWith(color: const Color(0xff6c86ad)),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (networkStatus.status == NetworkStatusType.online)
            IconTextButton(
              text: 'Connect',
              highlightColor: const Color(0xfffbfbfb),
              style: textTheme.labelMedium!.copyWith(color: const Color(0xff4888f0)),
              onTap: () {
                getIt<NetworkListCubit>().updateConnectedNetwork(networkStatus.interxUrl);
              },
            ),
          if (networkStatus.custom) ...<Widget>[
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                getIt<NetworkListCubit>().removeCustomNetwork(networkStatus.interxUrl);
              },
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                AppIcons.cancel,
                color: Color(0xff6c86ad),
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
                    color: Color(0x29fbfbfb),
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
