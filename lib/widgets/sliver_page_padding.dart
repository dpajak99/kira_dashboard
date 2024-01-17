import 'package:flutter/cupertino.dart';

class SliverPagePadding extends StatelessWidget {
  final Widget sliver;

  const SliverPagePadding({
    super.key,
    required this.sliver,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: switch (MediaQuery.of(context).size.width) {
          > 1200 => 200,
          > 800 => 100,
          (_) => 16,
        },
      ),
      sliver: sliver,
    );
  }
}
