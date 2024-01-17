import 'package:flutter/cupertino.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final String? title;

  const CustomCard({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff141924),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...<Widget>[
            Text(title!, style: const TextStyle(fontSize: 24, color: Color(0xfffbfbfb))),
            const SizedBox(height: 24),
          ],
          SizedBox(width: double.infinity, child: child),
        ],
      ),
    );
  }
}
