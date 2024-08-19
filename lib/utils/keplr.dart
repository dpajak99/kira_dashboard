@JS()
library keplr;

import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:js/js.dart';
import 'package:kira_dashboard/infra/entities/amino_sign_response.dart';
import 'package:kira_dashboard/models/wallet.dart';

// #2
@JS()
class KeplrApiWebInterface {
  external KeplrApiWebInterface();

  external dynamic getAccount();
  external bool isExtensionInstalled();
  external dynamic sign(String json);
}

class KeplrImpl {
  final KeplrApiWebInterface _keplr;

  KeplrImpl() : _keplr = KeplrApiWebInterface();

  Future<List<KeplrWallet>> getAccount() async  {
    String accounts = await promiseToFuture(_keplr.getAccount());
    List<dynamic> accountsList = jsonDecode(accounts);
    return accountsList.map((e) => KeplrWallet.fromJson(e)).toList();
  }

  Future<AminoSignResponse> signDirect(CosmosSignDoc cosmosSignDoc) async {
    Map<String, dynamic> cosmosSignDocBytes = <String, dynamic>{
      'bodyBytes': cosmosSignDoc.txBody.toProtoBytes(),
      'authInfoBytes': cosmosSignDoc.authInfo.toProtoBytes(),
      'chainId': cosmosSignDoc.chainId,
      'accountNumber': cosmosSignDoc.accountNumber,
    };

    dynamic response = await promiseToFuture(_keplr.sign(jsonEncode(cosmosSignDocBytes)));
    Map<String, dynamic> responseMap = jsonDecode(response);

    AminoSignResponse aminoSignResponse = AminoSignResponse.fromJson(responseMap);
    return aminoSignResponse;
  }

  bool get isExtensionInstalled => _keplr.isExtensionInstalled();
}