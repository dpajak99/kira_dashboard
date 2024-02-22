import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_route.dart';

class ScrollableAppBar extends SliverPersistentHeaderDelegate {
  final Widget child;

  const ScrollableAppBar({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 72;

  @override
  double get minExtent => 72;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget child;
  final double width;
  final EdgeInsets? contentPadding;

  const CustomDialog({
    required this.title,
    required this.child,
    required this.width,
    this.contentPadding,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CustomDialogRoute();
}

class _CustomDialogRoute extends State<CustomDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDialog oldWidget) {
    _controller.forward();
    super.didUpdateWidget(oldWidget);

  }


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        shadowColor: Colors.black,
        elevation: 10,
        insetPadding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            width: MediaQuery.of(context).size.width < 600 ? double.maxFinite : widget.width,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: CustomColors.dialog,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  child: Row(
                    children: [
                      if (DialogRouter().showBackButton)
                        IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: CustomColors.white,
                            size: 24,
                          ),
                          onPressed: () => DialogRouter().navigateBack(),
                        )
                      else
                        const SizedBox(width: 32),
                      Expanded(
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.headlineSmall!.copyWith(color: CustomColors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: CustomColors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
                      child: AnimatedOpacity(
                        opacity: 1,
                        duration: const Duration(milliseconds: 300),
                        child: FadeTransition(
                          opacity: _animation,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
