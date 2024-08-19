import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/theme/button_styles.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class SignTransactionDialog extends DialogContentWidget {
  final CosmosSignDoc cosmosSignDoc;

  const SignTransactionDialog({
    required this.cosmosSignDoc,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignTransactionDialog();
}

class _SignTransactionDialog extends State<SignTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Sign transaction',
      width: 420,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: CustomColors.dialogContainer,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                Text(
                  widget.cosmosSignDoc.toString(),
                  style: textTheme.bodyMedium!.copyWith(color: CustomColors.secondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: darkElevatedButton,
              onPressed: () {
                Wallet wallet = getIt<WalletProvider>().value as Wallet;
                Secp256k1PrivateKey privateKey = wallet.wallet.privateKey as Secp256k1PrivateKey;
                CosmosSigner cosmosSigner = CosmosSigner(privateKey.ecPrivateKey);

                CosmosSignature cosmosSignature = cosmosSigner.signDirect(widget.cosmosSignDoc);

                Navigator.of(context).pop(cosmosSignature);
              },
              child: const Text('Approve'),
            ),
          ),
        ],
      ),
    );
  }
}
