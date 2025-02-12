import 'package:my_vault/features/savings/domain/entities/withdraw.dart';
import 'package:my_vault/features/savings/domain/repositories/withdraw_repository.dart';

class AddWithdraw {
  final WithdrawRepository repository;

  AddWithdraw(this.repository);

  Future<void> call(Withdraw withdraw) {
    return repository.addWithdraw(withdraw);
  }
}