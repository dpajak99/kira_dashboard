import 'package:kira_dashboard/utils/aes/ciphertext.dart';

abstract interface class IEncryptionAlgorithm {
  Ciphertext encrypt(String password, String plaintext);

  String decrypt(String password, Ciphertext ciphertext);

  bool isPasswordValid(String password, Ciphertext ciphertext);
}