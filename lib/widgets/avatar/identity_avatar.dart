import 'package:blockies_svg/blockies_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kira_dashboard/widgets/avatar/url_avatar_widget.dart';

class IdentityAvatar extends StatelessWidget {
  final double size;
  final String address;
  final String? avatarUrl;

  const IdentityAvatar({
    required this.size,
    required this.address,
    this.avatarUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null) {
      return UrlAvatarWidget(
        address: address,
        url: avatarUrl!,
        size: size,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size*0.05),
        child: SizedBox(
          height: size,
          width: size,
          child: SvgPicture.string(
            Blockies(seed: address).toSvg(size: size.toInt()),
            width: size,
            height: size,
          ),
        ),
      );
    }
  }
}
