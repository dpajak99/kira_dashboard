import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

abstract class ListCubit<T> extends RefreshablePageCubit<T> {
  ListCubit(super.initialState);
}