import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/utils/router/router.gr.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';

class CopyableAddressText extends StatelessWidget {
  final String address;
  final bool full;
  final bool dark;

  const CopyableAddressText({
    super.key,
    required this.address,
    this.full = false,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return AddressText(
      address: address,
      icon: Icons.copy,
      full: full,
      dark: dark,
      onTap: () => _copyAddress(context),
    );
  }

  void _copyAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: address));
  }
}

class CopyableText extends StatelessWidget {
  final String text;

  const CopyableText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleTextButton(
      text: text,
      icon: Icons.copy,
      onTap: () => _copyText(context),
    );
  }

  void _copyText(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
  }
}

class OpenableAddressText extends StatelessWidget {
  final String? address;
  final bool full;

  const OpenableAddressText({
    super.key,
    required this.address,
    this.full = false,
  });

  @override
  Widget build(BuildContext context) {
    return AddressText(
      address: address,
      full: full,
      icon: Icons.open_in_new,
      onTap: () => _openAddress(context),
    );
  }

  void _openAddress(BuildContext context) {
    AutoRouter.of(context).push(PortfolioRoute(address: address!));
  }
}

class AddressText extends StatelessWidget {
  final String? address;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool full;
  final bool dark;

  const AddressText({
    super.key,
    required this.address,
    this.icon,
    this.onTap,
    this.full = false,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    
    if (address == null) {
      return Text(
        '---',
        style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
      );
    }
    return SimpleTextButton(
      text: full ? address! : '${address!.substring(0, 8)}...${address!.substring(address!.length - 4)}',
      icon: icon,
      dark: dark,
      onTap: onTap,
    );
  }
}

class SimpleTextButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final double gap;
  final double? rotateAngle;
  final bool reversed;
  final bool dark;

  const SimpleTextButton({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.gap = 8,
    this.rotateAngle,
    this.dark = false,
    this.reversed = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    
    Color highlightColor = Colors.white60;
    TextStyle style = textTheme.bodyMedium!.copyWith(color: dark? CustomColors.secondary : CustomColors.primary );
    
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        Widget? iconWidget = icon != null
            ? Icon(
                icon,
                size: 16,
                color: states.contains(MaterialState.hovered) ? highlightColor : style.color,
          
              )
            : null;

        if (rotateAngle != null) {
          iconWidget = Transform.rotate(angle: rotateAngle!, child: iconWidget);
        }

        if (reversed) {
          return RichText(
            text: TextSpan(
              text: '',
              children: [
                if (iconWidget != null)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(right: gap),
                      child: iconWidget,
                    ),
                  ),
                TextSpan(
                  text: text,
                  style: style.copyWith(
                    color: states.contains(MaterialState.hovered) && onTap != null ? highlightColor : style.color,
                  ),
                ),
              ],
            ),
          );
        }

        return RichText(
          text: TextSpan(
            text: text,
            style: style.copyWith(
              color: states.contains(MaterialState.hovered) && onTap != null ? highlightColor : style.color,
            ),
            children: [
              if (iconWidget != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.only(left: gap),
                    child: iconWidget,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
