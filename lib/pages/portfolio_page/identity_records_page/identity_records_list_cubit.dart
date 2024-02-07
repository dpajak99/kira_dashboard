import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_state.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/refreshable_page_cubit.dart';

class IdentityRecordsListCubit extends RefreshablePageCubit<IdentityRecordsListState> {
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();

  final String address;

  IdentityRecordsListCubit({
    required this.address,
  }) : super(const IdentityRecordsListState(isLoading: true));

  @override
  Future<void> reload() async {
    emit(const IdentityRecordsListState(isLoading: true));
    List<IdentityRecord> records = await identityRegistrarService.getAll(address);

    emit(state.copyWith(isLoading: false, records: records));
  }
}
