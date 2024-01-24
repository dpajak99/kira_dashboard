import 'package:bech32/bech32.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/widgets/avatar/identity_avatar.dart';

class AddressTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool locked;

  const AddressTextField({
    required this.title,
    required this.controller,
    this.locked = false,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController tmpController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);
  bool addressVisible = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChanged);
    if(widget.controller.text.isNotEmpty) {
      controller.text = widget.controller.text;
      confirmAddress();
    }
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
              InkWell(
                onTap: widget.locked ? null : () {},
                radius: 30,
                child: Icon(
                  widget.locked ? Icons.lock : Icons.paste,
                  color: const Color(0xff6c86ad),
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (addressVisible) ...[
                  Center(
                    child: IdentityAvatar(size: 25, address: tmpController.text),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Center(
                    child: TextField(
                      enabled: !widget.locked,
                      focusNode: focusNode,
                      controller: controller,
                      style: const TextStyle(fontSize: 20, color: Color(0xfffbfbfb)),
                      cursorColor: const Color(0xfffbfbfb),
                      cursorWidth: 1,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'kira...',
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

  void _handleFocusChanged() {
    bool addressValid = _validateAddress(controller.text);

    if (focusNode.hasFocus == false) {
      confirmAddress();
    } else {
      controller.text = tmpController.text;
    }

    setState(() {
      addressVisible = !focusNode.hasFocus && addressValid;
    });
  }

  void confirmAddress() {
    tmpController.text = controller.text;
    bool addressValid = _validateAddress(tmpController.text);

    if (addressValid) {
      controller.text = '${controller.text.substring(0, 15)}...${controller.text.substring(controller.text.length - 10)}';
      widget.controller.text = tmpController.text;
      errorNotifier.value = null;
    } else {
      widget.controller.text = '';
      errorNotifier.value = 'Invalid address';
    }

    setState(() {
      addressVisible = !focusNode.hasFocus && addressValid;
    });
  }

  bool _validateAddress(String address) {
    bool addressValid = true;
    try {
      bech32.decode(address);
    } catch (_) {
      addressValid = false;
    }
    return addressValid;
  }
}