import 'package:blockchain_utils/bip/mnemonic/mnemonic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog_state.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';
import 'package:kira_dashboard/widgets/custom_tab_bar.dart';

class SignInMnemonicDialog extends DialogContentWidget {
  const SignInMnemonicDialog({super.key});

  @override
  State<StatefulWidget> createState() => _SignInMnemonicDialog();
}

class _SignInMnemonicDialog extends State<SignInMnemonicDialog> with SingleTickerProviderStateMixin {
  final SignInMnemonicDialogCubit cubit = SignInMnemonicDialogCubit();
  late final TabController tabController = TabController(
    length: availableMnemonicSizes.length,
    vsync: this,
    initialIndex: availableMnemonicSizes.indexOf(24),
  );
  final List<int> availableMnemonicSizes = const <int>[12, 15, 18, 21, 24];

  @override
  void initState() {
    super.initState();
    cubit.setWordsCount(availableMnemonicSizes[tabController.index]);
    tabController.addListener(_updateMnemonicGridSize);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Sign in using Mnemonic',
      width: 550,
      scrollable: false,
      child: BlocBuilder<SignInMnemonicDialogCubit, SignInMnemonicDialogState>(
        bloc: cubit,
        builder: (BuildContext context, SignInMnemonicDialogState state) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xff10141C),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select mnemonic size',
                  style: TextStyle(fontSize: 12, color: Color(0xff6c86ad)),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTabBar(
                      tabController: tabController,
                      tabs: availableMnemonicSizes.map((int mnemonicSize) => Tab(text: mnemonicSize.toString())).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Enter mnemonic passphrase',
                  style: TextStyle(fontSize: 12, color: Color(0xff6c86ad)),
                ),
                const SizedBox(height: 8),
                ..._buildCells(state),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: state.valid
                      ? () {
                          signIn(cubit.mnemonicList);
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: const Text('Connect Wallet'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCells(SignInMnemonicDialogState state) {
    int columnsCount = 3;
    int rowsCount = state.wordsCount ~/ columnsCount;

    List<MnemonicTextField> cells = [];

    for (int i = 0; i < state.wordsCount; i++) {
      cells.add(MnemonicTextField(
        index: i + 1,
        controller: cubit.wordsControllers[i]!,
        pasteCallback: cubit.pasteValue,
        onChanged: cubit.validate,
      ));
    }

    return <Widget>[
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
                    child: cells[row * columnsCount + column]),
              ),
          ],
        ),
    ];
  }

  void _updateMnemonicGridSize() {
    cubit.setWordsCount(availableMnemonicSizes[tabController.index]);
  }

  void signIn(List<String> mnemonicList) {
    Mnemonic mnemonic = Mnemonic.fromList(mnemonicList);
    getIt<WalletProvider>().signIn(Wallet.fromMnemonic(mnemonic: mnemonic));
  }
}
