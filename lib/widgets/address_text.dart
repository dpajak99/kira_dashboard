import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
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
    return _AddressText(
      address: address,
      style: style,
      icon: Icons.copy,
      onTap: () => _copyAddress(context),
    );
  }

  void _copyAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: address));
  }
}

class OpenableAddressText extends StatelessWidget {
  final String? address;
  final TextStyle style;

  const OpenableAddressText({
    super.key,
    required this.address,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return _AddressText(
      address: address,
      style: style,
      icon: Icons.open_in_new,
      onTap: () => _openAddress(context),
    );
  }

  void _openAddress(BuildContext context) {
    AutoRouter.of(context).push(PortfolioRoute(address: address!));
  }
}

class _AddressText extends StatelessWidget {
  final String? address;
  final TextStyle style;
  final IconData icon;
  final VoidCallback onTap;

  const _AddressText({
    super.key,
    required this.address,
    required this.style,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if( address == null ) {
      return Text(
        '---',
        style: style,
      );
    }
    return IconTextButton(
      text: '${address!.substring(0, 8)}...${address!.substring(address!.length - 4)}',
      style: style,
      icon: icon,
      onTap: onTap,
    );
  }
}

class IconTextButton extends StatelessWidget {
  final String text;
  final TextStyle style;
  final IconData icon;
  final VoidCallback onTap;
  final double gap;
  final Color highlightColor;

  const IconTextButton({
    super.key,
    required this.text,
    required this.style,
    required this.icon,
    required this.onTap,
    this.highlightColor = const Color(0xff4888f0),
    this.gap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return RichText(
          text: TextSpan(
            text: text,
            style: style.copyWith(
              color: states.contains(MaterialState.hovered) ? highlightColor : style.color,
            ),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.only(left: gap),
                  child: Icon(
                    icon,
                    size: 16,
                    color: states.contains(MaterialState.hovered) ? highlightColor : style.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
