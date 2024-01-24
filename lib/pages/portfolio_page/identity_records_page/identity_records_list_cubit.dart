import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/portfolio_page/identity_records_page/identity_records_list_state.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class IdentityRecordsListCubit extends Cubit<IdentityRecordsListState> {
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();

  final String address;
  final bool isMyWallet;

  IdentityRecordsListCubit({
    required this.address,
    required this.isMyWallet,
  }) : super(const IdentityRecordsListState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    PaginatedRequest paginatedRequest = const PaginatedRequest(limit: 20, offset: 0);
    List<IdentityRecord> records = await identityRegistrarService.getPage(address, paginatedRequest);

    emit(state.copyWith(isLoading: false, records: records));
  }
}