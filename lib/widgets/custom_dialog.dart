import 'package:flutter/material.dart';
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

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final double width;
  final bool scrollable;

  const CustomDialog({
    required this.title,
    required this.child,
    required this.width,
    required this.scrollable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget childWidget;

    if (scrollable) {
      childWidget = CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: ScrollableAppBar(
              child: Container(
                color: const Color(0xff131823),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                height: 72,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (CustomDialogRoute.of(context).showBackButton)
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () => CustomDialogRoute.of(context).pop(),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
              child: child,
            ),
          ),
        ],
      );
    } else {
      childWidget = Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (CustomDialogRoute.of(context).showBackButton)
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => CustomDialogRoute.of(context).pop(),
                        ),
                      ),
                    ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      );
    }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            width: width,
            constraints: scrollable ? const BoxConstraints(maxHeight: 500) : null,
            decoration: const BoxDecoration(
              color: Color(0xff131823),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: childWidget,
          ),
        ),
      ),
    );
  }
}
