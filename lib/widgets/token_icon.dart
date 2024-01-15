import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        fit: BoxFit.contain,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return SizedBox(width: size, height: size);
        },
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        backgroundColor: const Color(0xff263042),
        child: child,
      ),
    );
  }
}
