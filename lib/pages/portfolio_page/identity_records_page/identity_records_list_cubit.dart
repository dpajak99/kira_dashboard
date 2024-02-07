import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/utils/cubits/list_cubit/list_cubit.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class IdentityRecordsListCubit extends PaginatedListCubit<IdentityRecord> {
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();

  final String address;

  IdentityRecordsListCubit({
    required this.address,
  }) : super(const PaginatedListState.loading());

  @override
  Future<List<IdentityRecord>> getPage(PaginatedRequest paginatedRequest) {
    return identityRegistrarService.getPage(address, paginatedRequest);
  }
}