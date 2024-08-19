import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class IWallet {
  String get address;

  int get index;

  Uint8List get publicKey;
}

class Wallet extends ChangeNotifier with EquatableMixin implements IWallet {
  final Secp256k1PrivateKey masterPrivateKey;
  final LegacyHDWallet wallet;
  final int accountNumber;

  Wallet._({
    required this.masterPrivateKey,
    required this.wallet,
    required this.accountNumber,
  });

  factory Wallet.fromMasterPrivateKey({
    required Secp256k1PrivateKey masterPrivateKey,
    required int addressIndex,
  }) {
    Secp256k1Derivator secp256k1Derivator = Secp256k1Derivator();

    List<LegacyHDWallet> wallets = [];
      Secp256k1PrivateKey privateKey = secp256k1Derivator.deriveChildKey(masterPrivateKey, LegacyDerivationPathElement.parse('$addressIndex'));

      LegacyHDWallet wallet = LegacyHDWallet(
        address: CosmosAddressEncoder(hrp: Slip173.kira).encodePublicKey(privateKey.publicKey),
        walletConfig: Bip44WalletsConfig.kira,
        privateKey: privateKey,
        publicKey: privateKey.publicKey,
        derivationPath: LegacyDerivationPath.parse("m/44'/118'/0'/0/$addressIndex"),
      );
      wallets.add(wallet);

    return Wallet._(
      masterPrivateKey: masterPrivateKey,
      wallet: wallet,
      accountNumber: addressIndex,
    );
  }

  static Future<Wallet> fromMnemonic(Mnemonic mnemonic) async {
    Secp256k1Derivator secp256k1derivator = Secp256k1Derivator();
    LegacyDerivationPath legacyDerivationPath = LegacyDerivationPath.parse("m/44'/118'/0'/0");
    Secp256k1PrivateKey secp256k1privateKey = await secp256k1derivator.deriveMasterKey(mnemonic);
    for(LegacyDerivationPathElement element in legacyDerivationPath.pathElements) {
      secp256k1privateKey = secp256k1derivator.deriveChildKey(secp256k1privateKey, element);
    }
    return Wallet.fromMasterPrivateKey(masterPrivateKey: secp256k1privateKey, addressIndex: 0);
  }

  @override
  int get index => accountNumber;

  @override
  Uint8List get publicKey => Uint8List.fromList(wallet.publicKey.bytes);

  @override
  String get address => wallet.address;

  @override
  List<Object?> get props => [address];
}

class KeplrWallet with EquatableMixin implements IWallet {
  @override
  final String address;
  final String algo;
  @override
  final Uint8List publicKey;

  const KeplrWallet({
    required this.address,
    required this.algo,
    required this.publicKey,
  });

  factory KeplrWallet.fromJson(Map<String, dynamic> json) {
    return KeplrWallet(
      address: json['address'],
      algo: json['algo'],
      publicKey: Uint8List.fromList((json['pubkey'] as Map<String, dynamic>).values.cast<int>().toList()),
    );
  }

  @override
  int get index => 0;

  @override
  List<Object?> get props => [address, algo, publicKey];
}
