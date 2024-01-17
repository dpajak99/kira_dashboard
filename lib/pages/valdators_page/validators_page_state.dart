import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class ValidatorsPageState extends PageState {
  final List<Validator> validators;

  const ValidatorsPageState({
    required super.isLoading,
    this.validators = const <Validator>[],
  });

  @override
  List<Object?> get props => <Object?>[validators];
}
