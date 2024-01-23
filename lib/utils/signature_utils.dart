import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:pointycastle/export.dart';

class SignatureUtils {
  static String generateSignature({required Wallet wallet, required String message}) {
    final Uint8List signatureDataHash = Uint8List.fromList(sha256.convert(utf8.encode(message)).bytes);

    final ECDomainParameters ecDomainParameters = ECCurve_secp256k1();
    final BigInt halfCurveOrder = ecDomainParameters.n >> 1;

    final ECDSASigner ecdsaSigner = ECDSASigner(null, HMac(SHA256Digest(), 64))
      ..init(true, PrivateKeyParameter<PrivateKey>(wallet.ecPrivateKey));

    ECSignature ecSignature = ecdsaSigner.generateSignature(signatureDataHash) as ECSignature;

    if (ecSignature.s.compareTo(halfCurveOrder) > 0) {
      final BigInt canonicalS = ecDomainParameters.n - ecSignature.s;
      ecSignature = ECSignature(ecSignature.r, canonicalS);
    }

    Uint8List signatureBytes = Uint8List.fromList(
      intToBytes(ecSignature.r) + intToBytes(ecSignature.s),
    );

    return base64Encode(signatureBytes);
  }

  static Uint8List intToBytes(BigInt number) {
    final int size = (number.bitLength + 7) >> 3;
    final Uint8List result = Uint8List(size);
    BigInt num = number;
    for (int i = 0; i < size; i++) {
      result[size - i - 1] = (num &  BigInt.from(0xff)).toInt();
      num = num >> 8;
    }
    return result;
  }
}
