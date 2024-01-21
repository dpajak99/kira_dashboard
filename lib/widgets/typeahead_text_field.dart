import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TypeaheadTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextStyle style;
  final Color suggestionColor;
  final List<String> suggestionList;
  final List<TextInputFormatter> inputFormatters;

  const TypeaheadTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.style,
    required this.suggestionColor,
    required this.suggestionList,
    required this.inputFormatters,
  });

  @override
  State<StatefulWidget> createState() => _TypeaheadTextField();
}

class _TypeaheadTextField extends State<TypeaheadTextField> {
  @override
  void initState() {
    widget.focusNode.addListener(_handleFocusChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.style.fontSize! * 1.5,
      child: Stack(
        alignment: Alignment.centerLeft,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (BuildContext context, TextEditingValue value, _) {
                  String hint = findHint(value.text);

                  return RichText(
                    maxLines: 1,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value.text,
                          style: widget.style,
                        ),
                        if (hint.isNotEmpty && hint != value.text && widget.focusNode.hasFocus)
                          TextSpan(
                            text: hint.substring(value.text.length),
                            style: widget.style.copyWith(
                              color: widget.suggestionColor,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: EditableText(
                undoController: null,
                selectionColor: Colors.white.withOpacity(0.2),
                maxLines: 1,
                backgroundCursorColor: Colors.transparent,
                inputFormatters: widget.inputFormatters,
                controller: widget.controller,
                focusNode: widget.focusNode,
                style: widget.style.copyWith(
                  color: Colors.transparent,
                ),
                cursorColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleFocusChanged() {
    if (widget.focusNode.hasFocus == false) {
      _completeEditing();
    }
  }

  void _completeEditing() {
    String hint = findHint(widget.controller.text);
    if (hint.isNotEmpty) {
      widget.controller.text = hint;
    }
  }

  String findHint(String text) {
    String hint = "";
    for (String suggestion in widget.suggestionList) {
      if (suggestion.startsWith(text) && text.isNotEmpty) {
        hint = suggestion;
      }
    }
    return hint;
  }
}
