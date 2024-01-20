import 'package:flutter/cupertino.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class DialogPage extends StatefulWidget {
  final DialogContentWidget content;

  const DialogPage({
    super.key,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => DialogPageState();

  static DialogPageState of(BuildContext context) {
    final DialogPageState? dialogPageState = context.findAncestorStateOfType<DialogPageState>();
    if (dialogPageState != null) {
      return dialogPageState;
    } else {
      throw Exception('Cannot get _DialogPageState state');
    }
  }
}

class DialogPageState extends State<DialogPage> {
  late DialogContentWidget content = widget.content;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: content.title,
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
