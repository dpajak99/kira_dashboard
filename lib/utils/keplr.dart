@JS()
library keplr;

import 'dart:convert';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:kira_dashboard/infra/entities/amino_sign_response.dart';
import 'package:kira_dashboard/infra/entities/transactions/out/transaction/std_sign_doc.dart';
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

  Future<AminoSignResponse> signAmino(StdSignDoc stdSignDoc) async {
    String json = jsonEncode(stdSignDoc.toSignatureJson());
    dynamic response = await promiseToFuture(_keplr.sign(json));
    Map<String, dynamic> responseMap = jsonDecode(response);

    AminoSignResponse aminoSignResponse = AminoSignResponse.fromJson(responseMap);
    return aminoSignResponse;
  }
}