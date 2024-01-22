import 'dart:async';

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

class DialogRouteConfig {
  final DialogContentWidget content;
  final Completer? completer;

  DialogRouteConfig({
    required this.content,
    Completer? completer,
  }) : completer = completer ?? Completer<void>();

  DialogRouteConfig.fromPage(DialogContentWidget page)
      : content = page,
        completer = Completer<void>();
}

class CustomDialogRouteState extends State<CustomDialogRoute> {
  late final List<DialogRouteConfig> routeStack = [
    DialogRouteConfig.fromPage(widget.content),
  ];

  @override
  Widget build(BuildContext context) {
    List<DialogContentWidget> pages = routeStack.map((e) => e.content).toList();
    List<Widget> pagesVisibility = <Widget>[];
    for (int i = 0; i < pages.length; i++) {
      bool pageVisible = i == pages.length - 1;

      pagesVisibility.add(Visibility(
        maintainState: true,
        maintainAnimation: true,
        visible: pageVisible,
        child: AnimatedOpacity(
          opacity: pageVisible ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: pages[i],
        ),
      ));
    }

    return Stack(
      children: pagesVisibility,
    );
  }

  @optionalTypeArgs
  Future<T> navigate<T>(DialogContentWidget page) async {
    Completer completer = Completer<T>();
    routeStack.add(DialogRouteConfig(
      content: page,
      completer: completer,
    ));
    setState(() {});
    return await completer.future;
  }

  void pop<T>([T? result]) {
    if (routeStack.isNotEmpty) {
      DialogRouteConfig dialogRouteConfig = routeStack.removeLast();
      dialogRouteConfig.completer?.complete(result);
      setState(() {});
    }
  }

  bool get showBackButton => routeStack.length > 1;
}
