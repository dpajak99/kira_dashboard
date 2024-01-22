import 'dart:convert';

import 'package:bech32/bech32.dart';
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
    String avatarData;
    try {
      Bech32 seperatedAddress = bech32.decode(address);
      avatarData = base64Encode(seperatedAddress.data);
    } catch (e) {
      avatarData = address;
    }
    if (avatarUrl != null) {
      return UrlAvatarWidget(
        address: avatarData,
        url: avatarUrl!,
        size: size,
      );
    } else {
      return ClipOval(
        child: SizedBox(
          height: size,
          width: size,
          child: SvgPicture.string(
            Blockies(seed: avatarData).toSvg(size: size.toInt()),
            width: size,
            height: size,
          ),
        ),
      );
    }
  }
}
