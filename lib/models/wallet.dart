import 'dart:typed_data';

import 'package:blockchain_utils/bip/bip/conf/bip_coin_conf.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_coins.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_conf_const.dart';
import 'package:blockchain_utils/bip/coin_conf/coins_name.dart';
import 'package:blockchain_utils/bip/mnemonic/mnemonic.dart';
import 'package:blockchain_utils/bip/slip/slip44/slip44.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:pointycastle/export.dart';

class KiraBip44Coin implements Bip44Coins {
  @override
  String get name => 'KIRA Network';

  @override
  String get coinName => 'KEX';

  @override
  CoinConfig get conf => CoinConfig(
        coinNames: const CoinNames("Kira NETWORK", "KEX"),
        coinIdx: Slip44.atom,
        isTestnet: false,
        defPath: derPathNonHardenedFull,
        keyNetVer: Bip32Const.mainNetKeyNetVersions,
        wifNetVer: null,
        type: EllipticCurveTypes.secp256k1,
        addressEncoder: ([dynamic kwargs]) => AtomAddrEncoder(),
        addrParams: {"hrp": 'kira'},
      );

  @override
  BipProposal get proposal => BipProposal.bip44;

  @override
  Bip44Coins get value => this;
}

abstract class IWallet extends Equatable {
  String get address;
  int get index;
  Uint8List get publicKey;

  const IWallet();
}

class Wallet extends IWallet {
  @override
  final int index;
  final Bip44 bip44;
  final Bip44 derivedBip44;

  Wallet.deriveDefaultPath(this.bip44)
      : derivedBip44 = bip44.deriveDefaultPath,
        index = 0;

  const Wallet({
    required this.index,
    required this.bip44,
    required this.derivedBip44,
  });

  Bip44 nextAccount() {
    return bip44.purpose.coin.account(0).change(Bip44Changes.chainExt).addressIndex(index + 1);
  }

  @override
  Uint8List get publicKey => Uint8List.fromList(derivedBip44.publicKey.compressed);

  factory Wallet.fromMnemonic({
    required Mnemonic mnemonic,
  }) {
    List<int> seed = Bip39SeedGenerator(mnemonic).generate();
    Bip44 bip44 = Bip44.fromSeed(seed, KiraBip44Coin());
    return Wallet.deriveDefaultPath(bip44);
  }

  ECPrivateKey get ecPrivateKey {
    final BigInt privateKeyInt = BigInt.parse(hex.encode(derivedBip44.privateKey.raw), radix: 16);
    return ECPrivateKey(privateKeyInt, ECCurve_secp256k1());
  }

  @override
  String get address => derivedBip44.publicKey.toAddress;

  @override
  List<Object?> get props => [address];
}


class KeplrWallet extends IWallet {
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