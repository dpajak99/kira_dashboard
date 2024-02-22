import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/address_text.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveTokensDialog extends DialogContentWidget {
  const ReceiveTokensDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ReceiveTokensDialog();
}

class _ReceiveTokensDialog extends State<ReceiveTokensDialog> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ValueListenableBuilder<IWallet?>(
      valueListenable: getIt<WalletProvider>(),
      builder: (BuildContext context, IWallet? wallet, _) {
        if (wallet == null) {
          return const SizedBox();
        }
        return CustomDialog(
          title: 'Receive tokens',
          width: 420,
          child: Column(
            children: [
              const SizedBox(height: 32),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: QrImageView(
                  data: wallet.address,
                  backgroundColor: CustomColors.white,
                  version: QrVersions.auto,
                  size: 200.0,
                  embeddedImage: const AssetImage('qr_placeholder.png'),
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(40, 40),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Your address',
                style: textTheme.labelMedium!.copyWith(color: CustomColors.secondary),
              ),
              CopyableAddressText(
                address: wallet.address,
                full: true,
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
