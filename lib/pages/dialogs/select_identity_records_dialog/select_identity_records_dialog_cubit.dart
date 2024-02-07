import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/identity_registrar_service.dart';
import 'package:kira_dashboard/models/identity_records.dart';
import 'package:kira_dashboard/pages/dialogs/select_identity_records_dialog/select_identity_records_dialog_state.dart';

class SelectIdentityRecordsDialogCubit extends Cubit<SelectIdentityRecordsDialogState> {
  final String address;
  final IdentityRegistrarService identityRegistrarService = IdentityRegistrarService();

  SelectIdentityRecordsDialogCubit({
    required this.address,
  }) : super(const SelectIdentityRecordsDialogState(records: [])) {
    init();
  }

  Future<void> init() async {
    List<IdentityRecord> records = await identityRegistrarService.getAll(address);
    emit(SelectIdentityRecordsDialogState(records: records));
  }
}
