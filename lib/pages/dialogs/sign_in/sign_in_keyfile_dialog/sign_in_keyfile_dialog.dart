import 'package:blockchain_utils/bech32/bech32_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/theme/app_colors.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/models/keyfile.dart';
import 'package:kira_dashboard/models/wallet.dart';
import 'package:kira_dashboard/pages/dialogs/dialog_content_widget.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_keyfile_dialog/sign_in_keyfile_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_keyfile_dialog/sign_in_keyfile_dialog_state.dart';
import 'package:kira_dashboard/widgets/custom_dialog.dart';

class SignInKeyfileDialog extends DialogContentWidget {
  const SignInKeyfileDialog({super.key});

  @override
  State<StatefulWidget> createState() => _SignInKeyfileDialog();
}

class _SignInKeyfileDialog extends State<SignInKeyfileDialog> {
  final SignInKeyfileDialogCubit cubit = SignInKeyfileDialogCubit();
  final ValueNotifier<bool> hoverNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CustomDialog(
      title: 'Sign in using Keyfile',
      width: 420,
      child: BlocBuilder<SignInKeyfileDialogCubit, SignInKeyfileDialogState>(
        bloc: cubit,
        builder: (BuildContext context, SignInKeyfileDialogState state) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: appColors.secondaryContainer,
                ),
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: hoverNotifier,
                        builder: (BuildContext context, bool hovered, _) {
                          Widget child = SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (hovered) ...<Widget>[
                                  Text(
                                    'Drop'.toUpperCase(),
                                    style: textTheme.titleLarge!.copyWith(
                                      color: appColors.onBackground,
                                    ),
                                  ),
                                ] else if (state.file != null) ...<Widget>[
                                  Icon(
                                    Icons.file_present,
                                    size: 40,
                                    color: appColors.secondary,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    state.file!.name,
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: appColors.onBackground,
                                    ),
                                  ),
                                  if (state.encryptedKeyfile != null)
                                    Text(
                                      Bech32Encoder.encode('kira', state.encryptedKeyfile!.addressBytes),
                                      style: textTheme.labelSmall!.copyWith(
                                        color: appColors.secondary,
                                      ),
                                    ),
                                  Text(
                                    state.file!.sizeString,
                                    style: textTheme.labelSmall!.copyWith(
                                      color: appColors.secondary,
                                    ),
                                  ),
                                ] else ...<Widget>[
                                  Icon(
                                    Icons.file_upload_outlined,
                                    size: 40,
                                    color: appColors.secondary,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Drop keyfile here'.toUpperCase(),
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: appColors.onBackground,
                                    ),
                                  ),
                                  Text(
                                    'Drag and drop your .json keyfile here or click to browse',
                                    style: textTheme.labelSmall!.copyWith(
                                      color: appColors.secondary,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          );

                          return child;
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: DropzoneView(
                        operation: DragOperation.copy,
                        cursor: CursorType.grab,
                        onHover: () => setState(() => hoverNotifier.value = true),
                        onLeave: () => setState(() => hoverNotifier.value = false),
                        onDrop: (dynamic files) {
                          cubit.handleDrop(files);
                          hoverNotifier.value = false;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appColors.secondaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: TextField(
                  controller: cubit.passwordController,
                  style: textTheme.bodyMedium!.copyWith(color: appColors.onBackground),
                  cursorColor: appColors.onBackground,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: 'Enter password',
                    hintStyle: textTheme.bodyMedium!.copyWith(color: appColors.secondaryContainer),
                    border: InputBorder.none,
                  ),
                  onChanged: (String value) => cubit.tryDecrypt(),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: state.decryptedKeyfile != null
                    ? () {
                        signIn(state.decryptedKeyfile!);
                        Navigator.of(context).pop();
                      }
                    : null,
                child: state.decryptedKeyfile != null ? const Text('Connect Wallet') : const Text('Enter valid password'),
              ),
            ],
          );
        },
      ),
    );
  }

  void signIn(DecryptedKeyfile decryptedKeyfile) {
    getIt<WalletProvider>().signIn(Wallet.fromPrivateKey(privateKey: decryptedKeyfile.privateKey));
  }
}
