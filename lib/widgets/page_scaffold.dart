import 'package:flutter/material.dart';

class PageScaffold extends StatefulWidget {
  final List<Widget> slivers;

  const PageScaffold({
    required this.slivers,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PageScaffold();
}

class _PageScaffold extends State<PageScaffold> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  const SliverPadding(padding: EdgeInsets.only(top: 64)),
                  ...widget.slivers,
                  const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
