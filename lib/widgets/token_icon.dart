import 'package:flutter/material.dart';

class TokenIcon extends StatelessWidget {
  final double size;
  final String? iconUrl;

  const TokenIcon({
    required this.size,
    this.iconUrl = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(width: size, height: size);

    if (iconUrl != null) {
      child = Image.network(
        iconUrl!,
        width: size,
        height: size,
        fit: BoxFit.fitHeight,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return SizedBox(width: size, height: size);
        },
      );
    }

    if (iconUrl == null) {
      return SizedBox(
        width: size,
        height: size,
        child: const CircleAvatar(backgroundColor: Color(0xff263042)),
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: child,
      );
    }
  }
}
