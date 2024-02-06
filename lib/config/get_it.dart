import 'package:get_it/get_it.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';
import 'package:kira_dashboard/pages/dialogs/account_dialog/account_dialog_cubit.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';

final GetIt getIt = GetIt.I;

Future<void> initLocator() async {
  getIt.registerLazySingleton(WalletProvider.new);
  getIt.registerLazySingleton(NetworkListCubit.new);
  getIt.registerLazySingleton(AccountDialogCubit.new);
}