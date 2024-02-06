import 'package:cached_network_image/cached_network_image.dart';
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
    Widget placeholderWidget = SizedBox(
      width: size,
      height: size,
      child: const CircleAvatar(backgroundColor: Color(0xff263042)),
    );

    if (iconUrl == null || iconUrl!.isEmpty) {
      return placeholderWidget;
    }

    Widget imageWidget;
    bool isSvg = iconUrl!.endsWith('.svg');

    if (isSvg) {
      imageWidget = SvgPicture.network(
        iconUrl!,
        placeholderBuilder: (_) => placeholderWidget,
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: iconUrl!,
        errorWidget: (_, __, ___) => placeholderWidget,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: imageWidget,
    );
  }
}
