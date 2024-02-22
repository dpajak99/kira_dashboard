import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class SizedShimmer extends StatelessWidget {
  final double width;
  final double height;
  final bool reversed;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  const SizedShimmer({
    required this.width,
    required this.height,
    this.borderRadius,
    this.padding,
    this.reversed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget shimmer;

    if (MediaQuery.of(context).size.width > 600) {
      shimmer = SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(width * 0.2),
          child: Shimmer.fromColors(
            baseColor: reversed ? appColors.secondary : appColors.secondaryContainer,
            highlightColor: reversed ? appColors.secondaryContainer.withOpacity(0.5) : appColors.secondary.withOpacity(0.2),
            child: Container(width: width, height: height, color: Colors.white.withOpacity(0.4)),
          ),
        ),
      );
    } else {
      shimmer = ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(width * 0.2),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(width * 0.3),
            color: appColors.secondaryContainer.withOpacity(0.4),
          ),
        ),
      );
    }

    if (padding != null) {
      shimmer = Padding(padding: padding!, child: shimmer);
    }

    return shimmer;
  }
}
