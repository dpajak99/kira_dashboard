import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class BlockDetailsPage extends StatefulWidget {
  final String? block;

  const BlockDetailsPage({
    super.key,
    @PathParam() required this.block,
  });

  @override
  State<StatefulWidget> createState() => _BlockDetailsPageState();
}

class _BlockDetailsPageState extends State<BlockDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
