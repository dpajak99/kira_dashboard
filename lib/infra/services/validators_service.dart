import 'package:kira_dashboard/infra/entities/paginated_response_wrapper.dart';
import 'package:kira_dashboard/infra/entities/validators/validator_entity.dart';
import 'package:kira_dashboard/infra/repository/validators_repository.dart';
import 'package:kira_dashboard/models/paginated_list_wrapper.dart';
import 'package:kira_dashboard/models/proposal.dart';
import 'package:kira_dashboard/models/validator.dart';
import 'package:kira_dashboard/utils/paginated_request.dart';

class ValidatorsService {
  final ValidatorsRepository validatorsRepository = ValidatorsRepository();

  Future<List<Validator>> getAll() async {
    List<ValidatorEntity> validatorEntities = await validatorsRepository.getAll();
    List<Validator> validators = validatorEntities.map((e) => Validator.fromEntity(e)).toList();

    return validators;
  }

  Future<PaginatedListWrapper<Validator>> getPage(PaginatedRequest paginatedRequest) async {
    PaginatedResponseWrapper<ValidatorEntity> response = await validatorsRepository.getPage(paginatedRequest);

    List<Validator> validators = response.items.map((ValidatorEntity e) => Validator.fromEntity(e)).toList();

    return PaginatedListWrapper<Validator>(items: validators, total: response.total);
  }


  Future<Validator?> getById(String address) async {
    ValidatorEntity? validatorEntity = await validatorsRepository.getById(address);
    return validatorEntity != null ? Validator.fromEntity(validatorEntity) : null;
  }
}