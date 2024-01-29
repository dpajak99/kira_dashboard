import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_list_cubit.dart';

abstract class RefreshablePageCubit<T> extends Cubit<T> {
  final NetworkListCubit networkListCubit = getIt<NetworkListCubit>();

  RefreshablePageCubit(super.initialState) {
    networkListCubit.networkStatusNotifier.listen(onChanged: (_) => reload());
    reload();
  }

  Future<void> reload();
}