import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/config/predefined_networks.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class NetworkDialog extends DialogContentWidget {
  const NetworkDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NetworkDialog();
}

class _NetworkDialog extends State<NetworkDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Select network',
      width: 420,
      scrollable: false,
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
        decoration: const BoxDecoration(
          color: Color(0xff06070a),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: ValueListenableBuilder(
          valueListenable: getIt<NetworkProvider>(),
          builder: (BuildContext context, Uri currentNetwork, _) {
            return Column(
              children: [
                ...PredefinedNetworks.networks.map((NetworkTemplate e) {
                  return ListTile(
                    onTap: () {},
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: const CircleIcon(
                      size: 30,
                      color: Colors.green,
                    ),
                    title: Text(
                      e.name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xfffbfbfb),
                      ),
                    ),
                    subtitle: Text(
                      e.interxUrl.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xff6c86ad),
                      ),
                    ),
                    trailing: currentNetwork != e.interxUrl
                        ? IconTextButton(
                            text: 'Connect',
                            highlightColor: const Color(0xfffbfbfb),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff4888f0),
                            ),
                            onTap: () {
                              getIt<NetworkProvider>().value = e.interxUrl;
                              // Navigator.pop(context);
                            },
                          )
                        : null,
                  );
                }),
              ],
            );
          },
        ),
      ),
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
                color: color.withOpacity(0.5),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.circle,
                size: size / 3,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
