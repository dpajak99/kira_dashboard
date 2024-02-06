import 'package:blockies_svg/blockies_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UrlAvatarWidget extends StatelessWidget {
  final double size;
  final String address;
  final String url;

  const UrlAvatarWidget({
    required this.size,
    required this.address,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double primaryAvatarSize = size;
    double secondaryAvatarSize = size * 0.4;

    Widget primaryAvatarWidget = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: NetworkImage(imageUrl: url),
    );

    Widget secondaryAvatarWidget = ClipOval(
      child: SizedBox(
        height: secondaryAvatarSize,
        width: secondaryAvatarSize,
        child: SvgPicture.string(
          Blockies(seed: address).toSvg(size: secondaryAvatarSize.toInt()),
          width: secondaryAvatarSize,
          height: secondaryAvatarSize,
        ),
      ),
    );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipOval(
              child: SizedBox(
                width: primaryAvatarSize,
                height: primaryAvatarSize,
                child: primaryAvatarWidget,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: secondaryAvatarWidget,
          ),
        ],
      ),
    );
  }
}

class NetworkImage extends StatelessWidget {
  final String? imageUrl;

  const NetworkImage({
    this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget placeholderWidget = const CircleAvatar(backgroundColor: Color(0xff263042));

    if (imageUrl == null || imageUrl!.isEmpty) {
      return placeholderWidget;
    }

    bool isSvg = imageUrl!.endsWith('.svg');

    if (isSvg) {
      return SvgPicture.network(
        imageUrl!,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => placeholderWidget,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => placeholderWidget,
      );
    }
  }
}
