import 'package:flutter/material.dart';

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
          color: const Color(0xff131823),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicator: ShapeDecoration(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: const Color(0xff2f8af5),
          ),
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xff6c86ad),
          tabs: tabs.map((Tab tab) {
            return Tab(text: tab.text ?? '');
          }).toList(),
        ),
      ),
    );
  }
}
