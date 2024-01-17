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
      slivers: slivers,
    );
  }
}