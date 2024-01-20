import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TypeaheadTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextStyle style;
  final Color suggestionColor;
  final List<String> suggestionList;
  final Function (String value, String hint)  onChanged;

  const TypeaheadTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.style,
    required this.suggestionColor,
    required this.suggestionList,
    required this.onChanged,
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
                        if (hint.isNotEmpty && hint != value.text)
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
              child: TextField(
                maxLines: 1,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  isDense: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(8),
                ],
                controller: widget.controller,
                focusNode: widget.focusNode,
                style: widget.style.copyWith(
                  color: Colors.transparent,
                ),
                onChanged: _onChanged,
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

  void _onChanged(String value) {
    String hint = findHint(value);
    widget.onChanged(value, hint);
  }

  void _completeEditing() {
    String hint = findHint(widget.controller.text);
    if (hint.isNotEmpty) {
      widget.controller.text = hint;
    }
    widget.onChanged(widget.controller.text, hint);
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
