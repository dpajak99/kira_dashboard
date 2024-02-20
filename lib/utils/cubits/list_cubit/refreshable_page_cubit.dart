import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/config/get_it.dart';
import 'package:kira_dashboard/pages/dialogs/network_dialog/network_cubit.dart';

abstract class RefreshablePageCubit<T> extends Cubit<T> {
  final NetworkCubit networkCubit = getIt<NetworkCubit>();

  RefreshablePageCubit(super.initialState) {
    networkCubit.networkStatusNotifier.listen(onChanged: (_) => reload());
    reload();
  }

  Future<void> reload();

  @override
  void emit(T state) {
    if( isClosed ) return;
    super.emit(state);
  }
}