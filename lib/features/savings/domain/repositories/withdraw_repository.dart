import 'package:dartz/dartz.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';

import '../../core/error/failures.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, List<Withdraw>>> getWithdraws();
  Future<void> addWithdraw(Withdraw withdraw);
}