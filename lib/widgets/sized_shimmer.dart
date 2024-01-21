import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SizedShimmer extends StatelessWidget {
  final double width;
  final double height;
  final bool reversed;

  const SizedShimmer({
    required this.width,
    required this.height,
    this.reversed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.1),
      child: Shimmer.fromColors(
        baseColor: reversed ? const Color(0xff6c86ad) : const Color(0xff131823),
        highlightColor: reversed ? const Color(0xff131823).withOpacity(0.5) : const Color(0xff6c86ad).withOpacity(0.2),
        child: Container(width: width, height: height, color: Colors.white.withOpacity(0.4)),
      ),
    );
  }
}