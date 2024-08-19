import 'package:flutter/material.dart';

class MouseStateListener extends StatefulWidget {
  final Widget Function(Set<WidgetState> states) childBuilder;
  final VoidCallback? onTap;

  const MouseStateListener({
    required this.childBuilder,
    this.onTap,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MouseStateListener();
}

class _MouseStateListener extends State<MouseStateListener> {
  final Set<WidgetState> _states = <WidgetState>{};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      highlightColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onHover: (bool hovered) {
        if (hovered) {
          _addState(WidgetState.hovered);
        } else {
          _removeState(WidgetState.hovered);
          _removeState(WidgetState.pressed);
        }
      },
      child: widget.childBuilder(_states),
    );
  }

  void _addState(WidgetState state) {
    _states.add(state);
    setState(() {});
  }

  void _removeState(WidgetState state) {
    _states.remove(state);
    setState(() {});
  }
}
