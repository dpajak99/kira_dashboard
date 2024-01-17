import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kira_dashboard/infra/services/validators_service.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/valdators_page/validators_page_state.dart';

class ValidatorsPageCubit extends Cubit<ValidatorsPageState> {
  final ValidatorsService validatorsService = ValidatorsService();

  ValidatorsPageCubit() : super(const ValidatorsPageState(isLoading: true));

  Future<void> init() async {
    List<Validator> validators = await validatorsService.getAll();

    emit(ValidatorsPageState(
      isLoading: false,
      validators: validators,
    ));
  }
}
