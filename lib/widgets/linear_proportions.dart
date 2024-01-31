import 'package:flutter/cupertino.dart';

class ProportionValue {
  final double value;
  final Color color;

  ProportionValue({required this.value, required this.color});
}

class LinearProportions extends StatelessWidget {
  final List<ProportionValue> proportions;

  const LinearProportions({super.key, required this.proportions});

  @override
  Widget build(BuildContext context) {
    List<ProportionValue> visibleProportions = proportions..sort((a, b) => (b.value.compareTo(a.value)));
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: visibleProportions.map((ProportionValue proportion) {
          return Expanded(
            flex: (proportion.value * 100).toInt(),
            child: Container(
              height: 8,
              color: proportion.color,
            ),
          );
        }).toList(),
      ),
    );
  }
}
