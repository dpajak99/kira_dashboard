import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_state.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_status.dart';
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

    return BlocBuilder<NetworkListCubit, NetworkListState>(
      bloc: getIt<NetworkListCubit>(),
      builder: (BuildContext context, NetworkListState state) {
        NetworkDetails? details = state.currentNetwork?.details;
        return CustomDialog(
          title: 'Select network',
          width: 420,
          child: Column(
            children: [
              if (state.currentNetwork != null) ...<Widget>[
                const Text('Current network'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xff06070a),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: CircleIcon(
                          size: 20,
                          color: switch (state.currentNetwork!.status) {
                            NetworkStatusType.online => Colors.green,
                            NetworkStatusType.unhealthy => Colors.yellow,
                            NetworkStatusType.offline => Colors.red,
                            NetworkStatusType.connecting => const Color(0xff6c86ad),
                          },
                        ),
                        title: Text(
                          state.currentNetwork!.name ?? 'unknown',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xfffbfbfb),
                          ),
                        ),
                        subtitle: Text(
                          state.currentNetwork!.interxUrl.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff6c86ad),
                          ),
                        ),
                        trailing: Text(
                          'Connected',
                          style: textTheme.bodyMedium!.copyWith(
                            color: switch (state.currentNetwork!.status) {
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
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Chain', style: TextStyle(fontSize: 12, color: Color(0xff6c86ad))),
                                Text(details?.chainId ?? '---', style: const TextStyle(fontSize: 12, color: Color(0xfffbfbfb))),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Block time', style: TextStyle(fontSize: 12, color: Color(0xff6c86ad))),
                                Text(details?.blockDateTime != null ? DateFormat('d MMM y, HH:mm').format(details!.blockDateTime) : '---',
                                    style: const TextStyle(fontSize: 12, color: Color(0xfffbfbfb))),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Block height', style: TextStyle(fontSize: 12, color: Color(0xff6c86ad))),
                                Text(details?.block.toString() ?? '---', style: const TextStyle(fontSize: 12, color: Color(0xfffbfbfb))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
              const Text('Available networks'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                  color: Color(0xff06070a),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    ...state.availableNetworks.map((NetworkStatus e) {
                      return ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: CircleIcon(
                          size: 20,
                          color: switch (e.status) {
                            NetworkStatusType.online => Colors.green,
                            NetworkStatusType.unhealthy => Colors.yellow,
                            NetworkStatusType.offline => Colors.red,
                            NetworkStatusType.connecting => const Color(0xff6c86ad),
                          },
                        ),
                        title: Text(
                          e.name ?? 'unknown',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xfffbfbfb),
                          ),
                        ),
                        subtitle: Text(
                          e.interxUrl.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff6c86ad),
                          ),
                        ),
                        trailing: e.status == NetworkStatusType.online
                            ? IconTextButton(
                                text: 'Connect',
                                highlightColor: const Color(0xfffbfbfb),
                                style: textTheme.bodyMedium!.copyWith(color:  const Color(0xff4888f0)),
                                onTap: () {
                                  getIt<NetworkListCubit>().updateConnectedNetwork(e.interxUrl);
                                },
                              )
                            : null,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xff06070a),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(fontSize: 16, color: Color(0xfffbfbfb)),
                        cursorColor: const Color(0xfffbfbfb),
                        cursorWidth: 1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Custom address',
                          hintStyle: TextStyle(fontSize: 16, color: Color(0xff3e4c63)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconTextButton(
                      text: 'Add',
                      highlightColor: const Color(0xfffbfbfb),
                      style: textTheme.bodyMedium!.copyWith(color:  const Color(0xff4888f0)),
                      onTap: () {
                        getIt<NetworkListCubit>().addCustomNetwork(NetworkTemplate(
                          name: 'Custom',
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

class CircleIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CircleIcon({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
