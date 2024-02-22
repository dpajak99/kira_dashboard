import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/widgets/mouse_state_listener.dart';

class OpenableHash extends StatelessWidget {
  final String hash;
  final VoidCallback onTap;
  final TextStyle style;

  const OpenableHash({
    super.key,
    required this.hash,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Row(
          children: [
            Expanded(
              child: Text(
                hash,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.open_in_new,
                size: 16,
                color: states.contains(MaterialState.hovered) ? appColors.onBackground : appColors.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}

class CopyableHash extends StatelessWidget {
  final String hash;
  final TextStyle style;

  const CopyableHash({
    super.key,
    required this.hash,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: () => Clipboard.setData(ClipboardData(text: hash)),
      childBuilder: (Set<MaterialState> states) {
        return Row(
          children: [
            Expanded(
              child: Text(
                hash,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.copy,
                size: 16,
                color: states.contains(MaterialState.hovered) ? appColors.onBackground : appColors.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}

class OpenableText extends StatelessWidget {
  final String? text;
  final VoidCallback onTap;
  final TextStyle style;

  const OpenableText({
    super.key,
    required this.text,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        if (text == null) {
          return Text('---', style: style);
        }
        return RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: text,
            style: style.copyWith(
              color: states.contains(MaterialState.hovered) ? Colors.white54 : appColors.secondary,
            ),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: states.contains(MaterialState.hovered) ? Colors.white54 : appColors.secondary,
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
