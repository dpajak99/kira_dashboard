import 'package:kira_dashboard/infra/entities/validators/validator_entity.dart';
import 'package:kira_dashboard/infra/repository/validators_repository.dart';
import 'package:kira_dashboard/models/validator.dart';

class ValidatorsService {
  final ValidatorsRepository validatorsRepository = ValidatorsRepository();

  Future<List<Validator>> getAll() async {
    List<ValidatorEntity> validatorEntities = await validatorsRepository.getAll();
    List<Validator> validators = validatorEntities.map((e) => Validator.fromEntity(e)).toList();

    return validators;
  }

  Future<Validator?> getById(String address) async {
    ValidatorEntity? validatorEntity = await validatorsRepository.getById(address);
    return validatorEntity != null ? Validator.fromEntity(validatorEntity) : null;
  }
}