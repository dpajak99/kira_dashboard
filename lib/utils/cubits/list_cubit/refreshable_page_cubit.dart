import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/config/network_provider.dart';

abstract class RefreshablePageCubit<T> extends Cubit<T> {
  final NetworkProvider networkProvider = getIt<NetworkProvider>();

  RefreshablePageCubit(super.initialState) {
    networkProvider.addListener(reload);
    reload();
  }

  Future<void> reload();
}