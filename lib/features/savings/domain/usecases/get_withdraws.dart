import 'package:dartz/dartz.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';
import 'package:my_vault/features/savings/domain/repositories/withdraw_repository.dart';

import '../../core/error/failures.dart';

class GetWithdraws {
  final WithdrawRepository repository;

  GetWithdraws(this.repository);

  Future<Either<Failure, List<Withdraw>>> call() async {
    return await repository.getWithdraws();
  }
}