import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const CustomTabBar({
    required this.tabController,
    required this.tabs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: appColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicator: ShapeDecoration(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: appColors.primary,
          ),
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: appColors.secondary,
          tabs: tabs.map((Tab tab) {
            return Tab(text: tab.text ?? '');
          }).toList(),
        ),
      ),
    );
  }
}
