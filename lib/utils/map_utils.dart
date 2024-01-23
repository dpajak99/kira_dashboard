import 'dart:collection';
import 'dart:convert';

class MapUtils {
  static Map<String, dynamic> flattenMap(Map<String, dynamic> map, [String prefix = '']) {
    Map<String, dynamic> result = <String, dynamic>{};

    map.forEach((String key, dynamic value) {
      String newKey = prefix.isEmpty ? key : '$prefix/$key';

      if (value is Map<String, dynamic>) {
        result.addAll(flattenMap(value, newKey));
      } else {
        result[newKey] = value;
      }
    });

    return result;
  }

  static String parseJsonToString(dynamic json, {required bool prettyPrintBool}) {
    if (prettyPrintBool) {
      String spaces = ' ' * 4;
      JsonEncoder encoder = JsonEncoder.withIndent(spaces);
      return encoder.convert(json);
    } else {
      JsonEncoder encoder = const JsonEncoder();
      return encoder.convert(json);
    }
  }

  /// Takes the given [map] and orders its values based on their keys.
  /// Returns the sorted map.
  static Map<String, dynamic> sort(Map<String, dynamic> map) {
    // Get the sorted keys
    final List<String> sortedKeys = map.keys.toList()..sort();

    // Sort each value
    final SplayTreeMap<String, dynamic> result = SplayTreeMap<String, dynamic>();
    for (String key in sortedKeys) {
      result[key] = _encodeValue(map[key]);
    }

    return result;
  }

  /// Takes a generic [value] and returns its sorted representation.
  /// * If it is a map, [sort] is called.
  /// * If it is a list, [_encodeList] is called.
  /// * Otherwise, the same value is returned.
  static dynamic _encodeValue(dynamic value) {
    if (value is Map) {
      return sort(value as Map<String, dynamic>);
    } else if (value is List) {
      return _encodeList(value);
    }
    return value;
  }

  /// Takes the given [value] and orders each one of the contained
  /// items that are present inside it by calling [_encodeValue].
  static List<dynamic> _encodeList(List<dynamic> value) {
    final List<dynamic> result = <dynamic>[];
    for (dynamic item in value) {
      result.add(_encodeValue(item));
    }
    return result;
  }

}
