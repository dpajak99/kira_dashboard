import 'package:blockchain_utils/bip/address/atom_addr.dart';
import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_coin_conf.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_coins.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_conf_const.dart';
import 'package:blockchain_utils/bip/coin_conf/coins_name.dart';
import 'package:blockchain_utils/bip/ecc/curve/elliptic_curve_types.dart';
import 'package:blockchain_utils/bip/mnemonic/mnemonic.dart';
import 'package:blockchain_utils/bip/slip/slip44/slip44.dart';

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
        addrParams: {
          "hrp": 'kira'
        },
      );

  @override
  BipProposal get proposal => BipProposal.bip44;

  @override
  Bip44Coins get value => this;
}

class Wallet {
  final Bip44 bip44;
  final Bip44 derivedBip44;

  Wallet.deriveDefaultPath(this.bip44) : derivedBip44 = bip44.deriveDefaultPath;

  factory Wallet.fromMnemonic({
    required Mnemonic mnemonic,
  }) {
    List<int> seed = Bip39SeedGenerator(mnemonic).generate();
    Bip44 bip44 = Bip44.fromSeed(seed, KiraBip44Coin());
    return Wallet.deriveDefaultPath(bip44);
  }

  String get address => derivedBip44.publicKey.toAddress;
}
