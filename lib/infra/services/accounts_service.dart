import 'package:kira_dashboard/infra/entities/account/account_entity.dart';
import 'package:kira_dashboard/infra/repository/accounts_repository.dart';

class AccountsService {
  final AccountsRepository accountsRepository = AccountsRepository();

  Future<String> getTransactionsCount(String address) async {
    AccountEntity accountEntity = await accountsRepository.get(address);
    return accountEntity.sequence;
  }
}