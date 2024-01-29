import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kira_dashboard/main.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';

class _DialogRouteConfig {
  final DialogContentWidget content;
  final Completer? completer;

  _DialogRouteConfig({
    required this.content,
    Completer? completer,
  }) : completer = completer ?? Completer<void>();

  _DialogRouteConfig.fromPage(DialogContentWidget page)
      : content = page,
        completer = Completer<void>();
}

class DialogRouter {
  static final DialogRouter _singleton = DialogRouter._internal();

  factory DialogRouter() {
    return _singleton;
  }

  factory DialogRouter.seperated() {
    _singleton.childRoute = DialogRouter._internal(_singleton);
    return _singleton.childRoute!;
  }

  DialogRouter._internal([this.rootRoute]);

  GlobalKey dialogKey = GlobalKey();

  DialogRouter? rootRoute;
  DialogRouter? childRoute;

  Future<T?> navigate<T>(DialogContentWidget page) async {
    if (_currentState != null) {
      return _currentState!.navigate<T>(page);
    } else {
      T? result = await showDialog<T>(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => _CustomDialogRoute(
          key: dialogKey,
          firstPage: page,
        ),
      );
      rootRoute?.childRoute = null;
      return result;
    }
  }

  Future<T?> replace<T>(DialogContentWidget page) async {
    if (_currentState != null) {
      return _currentState!.replace(page);
    } else {
      return null;
    }
  }

  Future<T?> replaceAll<T>(DialogContentWidget page) async {
    if (_currentState != null) {
      return _currentState!.replaceAll(page);
    } else {
      return null;
    }
  }

  void navigateBack<T>([T? result]) {
    if (_currentState != null) {
      return _currentState!.navigateBack(result);
    } else {
      return Navigator.of(navigatorKey.currentContext!).pop(result);
    }
  }

  bool get showBackButton {
    if (_currentState != null) {
      return _currentState!.showBackButton;
    } else {
      return false;
    }
  }

  _CustomDialogRouteState? get _currentState {
    if (childRoute != null) {
      return childRoute!._currentState;
    } else if (dialogKey.currentState != null) {
      return dialogKey.currentState as _CustomDialogRouteState;
    } else {
      return null;
    }
  }
}

class _CustomDialogRoute extends StatefulWidget {
  final DialogContentWidget? firstPage;

  const _CustomDialogRoute({super.key, this.firstPage});

  @override
  State<StatefulWidget> createState() => _CustomDialogRouteState();
}

class _CustomDialogRouteState extends State<_CustomDialogRoute> {
  final List<_DialogRouteConfig> routeStack = <_DialogRouteConfig>[];

  @override
  void initState() {
    super.initState();
    if (widget.firstPage != null) {
      routeStack.add(_DialogRouteConfig.fromPage(widget.firstPage!));
    }
  }

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
    routeStack.add(_DialogRouteConfig(
      content: page,
      completer: completer,
    ));
    setState(() {});
    return await completer.future;
  }

  @optionalTypeArgs
  Future<T> replace<T>(DialogContentWidget page) async {
    Completer completer = Completer<T>();
    routeStack.removeLast();
    routeStack.add(_DialogRouteConfig(
      content: page,
      completer: completer,
    ));
    setState(() {});
    return await completer.future;
  }

  @optionalTypeArgs
  Future<T?> replaceAll<T>(DialogContentWidget page) async {
    Completer completer = Completer<T>();
    routeStack.clear();
    routeStack.add(_DialogRouteConfig(
      content: page,
      completer: completer,
    ));
    setState(() {});
    return await completer.future;
  }

  void navigateBack<T>([T? result]) {
    if (routeStack.isNotEmpty) {
      _DialogRouteConfig dialogRouteConfig = routeStack.removeLast();
      dialogRouteConfig.completer?.complete(result);
      setState(() {});
    }
  }

  bool get showBackButton => routeStack.length > 1;
}
