import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/pages/page_state.dart';

class ValidatorsPageState extends PageState {
  final List<Validator> validators;
  final bool isSignedIn;

  const ValidatorsPageState({
    required super.isLoading,
    this.validators = const <Validator>[],
    this.isSignedIn = false,
  });

  ValidatorsPageState copyWith({
    bool? isLoading,
    List<Validator>? validators,
    bool? isSignedIn,
  }) {
    return ValidatorsPageState(
      isLoading: isLoading ?? this.isLoading,
      validators: validators ?? this.validators,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  List<Object?> get props => <Object?>[isLoading, isSignedIn, validators];
}
