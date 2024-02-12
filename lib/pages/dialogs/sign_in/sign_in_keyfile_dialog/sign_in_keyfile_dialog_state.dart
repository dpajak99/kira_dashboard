import 'package:equatable/equatable.dart';
import 'package:kira_dashboard/models/custom_file.dart';
import 'package:kira_dashboard/models/keyfile.dart';

class SignInKeyfileDialogState extends Equatable {
  final CustomFile? file;
  final EncryptedKeyfile? encryptedKeyfile;
  final DecryptedKeyfile? decryptedKeyfile;

  const SignInKeyfileDialogState({
    this.file,
    this.encryptedKeyfile,
    this.decryptedKeyfile
  });

  @override
  List<Object?> get props => [file, encryptedKeyfile, decryptedKeyfile];
}
