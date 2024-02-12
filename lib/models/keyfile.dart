import 'dart:convert';
import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';

class EncryptedKeyfile {
  final Uint8List addressBytes;
  final Map<String, dynamic> secretData;

  EncryptedKeyfile({
    required this.addressBytes,
    required this.secretData,
  });

  factory EncryptedKeyfile.fromJson(Map<String, dynamic> json) {
    return EncryptedKeyfile(
      addressBytes: base64Decode(json['address_bytes']),
      secretData: json['secret_data'],
    );
  }

  bool validatePassword(String password) {
    return AESDHKEV1().isPasswordValid(password, Ciphertext.fromJson(secretData));
  }

  DecryptedKeyfile decrypt(String password) {
    String decrypted = AESDHKEV1().decrypt(password, Ciphertext.fromJson(secretData));
    Map<String, dynamic> json = jsonDecode(decrypted);
    return DecryptedKeyfile(
      addressBytes: addressBytes,
      privateKey: Uint8List.fromList(hex.decode(json['privateKey'])),
    );
  }
}

class DecryptedKeyfile {
  final Uint8List addressBytes;
  final Uint8List privateKey;

  DecryptedKeyfile({
    required this.addressBytes,
    required this.privateKey,
  });
}