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
          > 1600 => 200,
          > 1200 => 50,
          > 800 => 25,
          (_) => 16,
        },
      ),
      sliver: sliver,
    );
  }
}
