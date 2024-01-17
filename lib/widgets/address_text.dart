import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';

class CopyableAddressText extends StatelessWidget {
  final String address;
  final TextStyle style;

  const CopyableAddressText({
    super.key,
    required this.address,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _copyAddress(context),
      child: _AddressText(address: address, style: style, icon: Icons.copy),
    );
  }

  void _copyAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: address));
  }
}

class OpenableAddressText extends StatelessWidget {
  final String address;
  final TextStyle style;

  const OpenableAddressText({
    super.key,
    required this.address,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(childBuilder: (Set<MaterialState> states) {
      return _AddressText(
        address: address,
        style: style.copyWith(
          color: states.contains(MaterialState.hovered) ? const Color(0xff4888f0) : style.color,
        ),
        icon: Icons.open_in_new,
      );
    });
  }

  void _openAddress(BuildContext context) {}
}

class _AddressText extends StatelessWidget {
  final String address;
  final TextStyle style;
  final IconData icon;

  const _AddressText({
    super.key,
    required this.address,
    required this.style,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${address.substring(0, 8)}...${address.substring(address.length - 4)}',
        style: style,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(icon, size: 16, color: style.color),
            ),
          ),
        ],
      ),
    );
  }
}
