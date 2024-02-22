import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/models/custom_file.dart';
import 'package:kira_dashboard/models/keyfile.dart';
import 'package:kira_dashboard/pages/dialogs/sign_in/sign_in_keyfile_dialog/sign_in_keyfile_dialog_state.dart';

class SignInKeyfileDialogCubit extends Cubit<SignInKeyfileDialogState> {
  final TextEditingController passwordController = TextEditingController();

  SignInKeyfileDialogCubit() : super(const SignInKeyfileDialogState());

  Future<void> handleDrop(dynamic file) async {
    CustomFile customFile = await CustomFile.fromHtmlFile(file);
    EncryptedKeyfile? encryptedKeyfile;

    try {
      encryptedKeyfile = EncryptedKeyfile.fromJson(jsonDecode(customFile.content));
    } catch (e) {
      // emit error
    }
    emit(SignInKeyfileDialogState(file: customFile, encryptedKeyfile: encryptedKeyfile));
    tryDecrypt();
  }

  Future<void> tryDecrypt() async {
    if (state.encryptedKeyfile == null) {
      emit(SignInKeyfileDialogState(file: state.file, encryptedKeyfile: null, decryptedKeyfile: null));
      return;
    }
    String password = passwordController.text;
    bool isValid = state.encryptedKeyfile!.validatePassword(password);
    if (!isValid) {
      emit(SignInKeyfileDialogState(file: state.file, encryptedKeyfile: state.encryptedKeyfile, decryptedKeyfile: null));
      return;
    }
    DecryptedKeyfile decryptedKeyfile = state.encryptedKeyfile!.decrypt(password);
    emit(SignInKeyfileDialogState(file: state.file, encryptedKeyfile: state.encryptedKeyfile, decryptedKeyfile: decryptedKeyfile));
  }
}
