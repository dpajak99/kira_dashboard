import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:blockchain_utils/bip/mnemonic/mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class CreateWalletDialog extends DialogContentWidget {
  const CreateWalletDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectWalletDialogState();
}

class _ConnectWalletDialogState extends State<CreateWalletDialog> {
  late Mnemonic mnemonic;
  bool termsAccepted = false;

  @override
  void initState() {
    refreshMnemonic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    int columnsCount = 3;
    List<String> mnemonicWords = mnemonic.toList();
    int rowsCount = mnemonicWords.length ~/ columnsCount;

    return CustomDialog(
      title: 'Create Wallet',
      width: 550,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: appColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Write down your Secret Recovery Phrase',
                  style: textTheme.titleSmall!.copyWith(color: appColors.onBackground),
                ),
                const SizedBox(height: 8),
                Text(
                  'Write down this 24-word Secret Recovery Phrase and save it in a place that you trust and only you can access.',
                  style: textTheme.bodySmall!.copyWith(color: appColors.secondary),
                ),
                const SizedBox(height: 24),
                for (int row = 0; row < rowsCount; row++)
                  Row(
                    children: [
                      for (int column = 0; column < columnsCount; column++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: row == 0 ? 0 : 8,
                              left: column == 0 ? 0 : 8,
                              right: column == columnsCount - 1 ? 0 : 8,
                              bottom: row == rowsCount - 1 ? 0 : 8,
                            ),
                            child: _MnemonicItem(
                              index: row * columnsCount + column + 1,
                              word: mnemonicWords[row * columnsCount + column],
                            ),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: refreshMnemonic, icon: const Icon(Icons.refresh, size: 20), color: appColors.primary),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.copy, size: 20), color: appColors.primary),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code, size: 20), color: appColors.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: termsAccepted,
                onChanged: (bool? value) => setState(() => termsAccepted = value ?? false),
                activeColor: appColors.primary,
                side: BorderSide(color: appColors.primary, width: 2),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'I have written down all 24 recovery words in their correct order and understand if I lose any one of them, or even unknowingly reveal, ALL my assets and data secured by this wallet might be stolen or irrecoverable.',
                  style: textTheme.labelSmall!.copyWith(color: appColors.secondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: termsAccepted
                ? () {
                    signIn();
                    Navigator.of(context).pop();
                  }
                : null,
            child: const Text('Create Wallet'),
          ),
        ],
      ),
    );
  }

  void refreshMnemonic() {
    setState(() {
      mnemonic = Bip39MnemonicGenerator().fromWordsNumber(Bip39WordsNum.wordsNum24);
    });
  }

  void signIn() {
    getIt<WalletProvider>().signIn(Wallet.fromMnemonic(mnemonic: mnemonic));
  }
}

class _MnemonicItem extends StatelessWidget {
  final int index;
  final String word;

  const _MnemonicItem({
    required this.index,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: appColors.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$index.',
              style: textTheme.bodyMedium!.copyWith(color: appColors.secondary),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            word,
            style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
          ),
        ],
      ),
    );
  }
}
