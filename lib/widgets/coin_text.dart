import 'package:flutter/material.dart';
import 'package:kira_dashboard/models/coin.dart';

class CoinText extends StatelessWidget {
  final Coin coin;
  final TextAlign textAlign;
  final TextStyle style;

  const CoinText({
    required this.coin,
    required this.textAlign,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String prefixedTokenAmountString = coin.toNetworkDenominationString(prettify: true);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        TextPainter painter = TextPainter(
          maxLines: 1,
          textAlign: textAlign,
          textDirection: TextDirection.ltr,
          text: TextSpan(style: style, text: prefixedTokenAmountString),
        )..layout(maxWidth: size.maxWidth);

        if (painter.didExceedMaxLines) {
          return Text(
            _buildShortString(size.maxWidth - 10),
            textAlign: textAlign,
            maxLines: 1,
            style: style,
          );
        } else {
          return Text(
            prefixedTokenAmountString,
            maxLines: 1,
            textAlign: textAlign,
            style: style,
          );
        }
      },
    );
  }

  String _buildShortString(double maxWidth) {
    String prefix = '>';
    StringBuffer valueText = StringBuffer('9');
    String denom = coin.symbol;

    String finalText = '$prefix$valueText $denom';

    bool maxValueFoundBool = false;
    while (maxValueFoundBool == false) {
      valueText.write('9');
      String newFinalText = '$prefix$valueText $denom';

      TextPainter painter = TextPainter(
        maxLines: 1,
        textAlign: textAlign,
        textDirection: TextDirection.ltr,
        text: TextSpan(style: style, text: newFinalText),
      )..layout(maxWidth: maxWidth);

      if (painter.didExceedMaxLines) {
        maxValueFoundBool = true;
      } else {
        finalText = newFinalText;
      }
    }

    return finalText;
  }
}
