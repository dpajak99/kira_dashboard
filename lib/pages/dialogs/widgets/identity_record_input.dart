import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RecordConfig extends Equatable {
  final int maxLength;

  const RecordConfig({
    required this.maxLength,
  });

  @override
  List<Object?> get props => [maxLength];
}

Map<String, RecordConfig> predefinedKeysConfig = <String, RecordConfig>{
  'username': const RecordConfig(maxLength: 32),
};

class IdentityRecordInputModel {
  final TextEditingController keyController;
  final TextEditingController valueController;

  IdentityRecordInputModel()
      : keyController = TextEditingController(),
        valueController = TextEditingController();

  IdentityRecordInputModel.fromValues({required String key, required String value})
      : keyController = TextEditingController(text: key),
        valueController = TextEditingController(text: value);

  IdentityRecordInputModel copy() {
    return IdentityRecordInputModel()
      ..keyController.text = keyController.text
      ..valueController.text = valueController.text;
  }
}

class IdentityRecordInputController extends ValueNotifier<IdentityRecordInputModel> {
  IdentityRecordInputController() : super(IdentityRecordInputModel());

  IdentityRecordInputController.fromValue(super.value);

  factory IdentityRecordInputController.copy(IdentityRecordInputController other) {
    return IdentityRecordInputController.fromValue(other.value.copy());
  }

  String get irValue => value.valueController.text;

  String get irKey => value.keyController.text;

  bool get hasValue => irValue.isNotEmpty;

  bool get hasKey => irKey.isNotEmpty;

  bool get isValid {
    if (irKey.isEmpty) {
      return false;
    }
    if (irValue.isEmpty) {
      return false;
    }
    return true;
  }
}

class IdentityRecordInput extends StatefulWidget {
  final IdentityRecordInputController controller;

  const IdentityRecordInput({
    super.key,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _IdentityRecordInputState();
}

class _IdentityRecordInputState extends State<IdentityRecordInput> {
  RecordConfig? config;

  @override
  void initState() {
    super.initState();
    _validate();
    widget.controller.value.keyController.addListener(_validate);
  }

  @override
  void dispose() {
    widget.controller.value.keyController.removeListener(_validate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TextField(
                title: 'Key',
                controller: widget.controller.value.keyController,
              ),
              const SizedBox(height: 16),
              _TextField(
                title: 'Value',
                maxLines: 3,
                maxLength: config?.maxLength,
                controller: widget.controller.value.valueController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _validate() {
    String normalizedKey = widget.controller.irKey.toLowerCase();
    if (predefinedKeysConfig.containsKey(normalizedKey)) {
      config = predefinedKeysConfig[normalizedKey];
    } else {
      config = null;
    }
    setState(() {});
  }
}

class _TextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final int maxLines;
  final int? maxLength;

  const _TextField({
    required this.controller,
    required this.title,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  final FocusNode focusNode = FocusNode();
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff06070a),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 13, color: Color(0xff6c86ad)),
              ),
              const Spacer(),
              const Spacer(),
              InkWell(
                onTap: () => widget.controller.clear(),
                radius: 30,
                child: const Icon(
                  Icons.brush,
                  color: Color(0xff6c86ad),
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: widget.maxLines * 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: TextField(
                      maxLength: widget.maxLength,
                      maxLines: widget.maxLines,
                      focusNode: focusNode,
                      controller: widget.controller,
                      style: const TextStyle(fontSize: 20, color: Color(0xfffbfbfb)),
                      cursorColor: const Color(0xfffbfbfb),
                      cursorWidth: 1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'Enter value',
                        hintStyle: TextStyle(fontSize: 20, color: Color(0xff3e4c63)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: errorNotifier,
                builder: (BuildContext context, String? errorMessage, _) {
                  if (errorMessage != null) {
                    return Text(
                      errorMessage,
                      style: const TextStyle(fontSize: 13, color: Color(0xfff12e1f)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
