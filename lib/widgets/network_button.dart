import 'package:flutter/material.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_dialog.dart';

class NetworkButton extends StatelessWidget {
  const NetworkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => DialogRouter().navigate(const NetworkDialog()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: const BoxDecoration(
          color: Color(0xff4888f0),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.network_wifi_rounded,
              size: 18,
            ),
            SizedBox(width: 8),
            Text(
              'localnet-1',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
