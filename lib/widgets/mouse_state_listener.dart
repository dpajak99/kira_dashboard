import 'package:flutter/material.dart';

class MouseStateListener extends StatefulWidget {
  final Widget Function(Set<MaterialState> states) childBuilder;
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
  final Set<MaterialState> _states = <MaterialState>{};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () {},
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onHover: (bool hovered) {
        if (hovered) {
          _addState(MaterialState.hovered);
        } else {
          _removeState(MaterialState.hovered);
          _removeState(MaterialState.pressed);
        }
      },
      child: widget.childBuilder(_states),
    );
  }

  void _addState(MaterialState state) {
    _states.add(state);
    setState(() {});
  }

  void _removeState(MaterialState state) {
    _states.remove(state);
    setState(() {});
  }
}
