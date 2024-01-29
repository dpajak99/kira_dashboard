import 'dart:typed_data';

import 'package:bech32/bech32.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

void main() {
  List<int> dec = hex.decode('29298EE5081B1DA669AAF90C76554127B2AD87CF');
  print(dec);

  bech32.encode(Bech32('kira', dec));
}