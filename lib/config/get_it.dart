import 'package:get_it/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';
import 'package:kira_dashboard/config/wallet_provider.dart';

final GetIt getIt = GetIt.I;

Future<void> initLocator() async {
  getIt.registerLazySingleton(NetworkProvider.new);
  getIt.registerLazySingleton(WalletProvider.new);
}