import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/mnemonic_text_field/mnemonic_text_field.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in_mnemonic_dialog/sign_in_mnemonic_dialog_state.dart';
import 'package:kira_dashboard/widgets/custom_tab_bar.dart';

class SignInMnemonicDialog extends DialogContentWidget {
  const SignInMnemonicDialog({super.key});

  @override
  String get title => 'Sign in using Mnemonic';

  @override
  double get width => 550;

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
    tabController.addListener(_updateMnemonicGridSize);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInMnemonicDialogCubit, SignInMnemonicDialogState>(
      bloc: cubit,
      builder: (BuildContext context, SignInMnemonicDialogState state) {
        int columnsCount = 3;
        int rowsCount = state.wordsCount ~/ columnsCount;

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
                          child: MnemonicTextField(
                            index: row * columnsCount + column + 1,
                            word: state.words[row * columnsCount + column],
                            onConfirmed: (String word) => cubit.setWord(row * columnsCount + column, word),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  void _updateMnemonicGridSize() {
    cubit.setWordsCount(availableMnemonicSizes[tabController.index]);
  }
}
