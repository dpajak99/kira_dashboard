import 'package:decimal/decimal.dart';

class DecimalUtils {
  static String prettifyDecimal(Decimal decimal) {
    List<String> decimalParts = decimal.toString().split('.');
    String integerPart = decimalParts[0];
    String fractionalPart = decimalParts.length > 1 ? decimalParts[1] : '';

    return '${_separateThousands(integerPart)}${fractionalPart.isNotEmpty ? '.' : ''}$fractionalPart';
  }

  static String _separateThousands(String integerPart) {
    String result = '';
    int length = integerPart.length;
    for (int i = 0; i < length; i++) {
      result += integerPart[i];
      if ((length - i - 1) % 3 == 0 && i != length - 1) {
        result += ' ';
      }
    }
    return result;
  }
}