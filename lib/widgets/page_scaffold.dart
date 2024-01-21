import 'package:flutter/cupertino.dart';

class PageScaffold extends StatelessWidget {
  final List<Widget> slivers;

  const PageScaffold({
    required this.slivers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverPadding(padding: EdgeInsets.only(top: 64)),
        ...slivers,
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ]
    );
  }
}