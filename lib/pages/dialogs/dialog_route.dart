import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class CustomDialogRoute extends StatefulWidget {
  final DialogContentWidget content;

  const CustomDialogRoute({
    super.key,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => CustomDialogRouteState();

  static CustomDialogRouteState of(BuildContext context) {
    final CustomDialogRouteState? dialogPageState = context.findAncestorStateOfType<CustomDialogRouteState>();
    if (dialogPageState != null) {
      return dialogPageState;
    } else {
      throw Exception('Cannot get _DialogPageState state');
    }
  }
}

class CustomDialogRouteState extends State<CustomDialogRoute> {
  late DialogContentWidget content = widget.content;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: content.title,
      width: content.width,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: content,
      ),
    );
  }

  void navigate(DialogContentWidget page) {
    setState(() {
      content = page;
    });
  }
}
