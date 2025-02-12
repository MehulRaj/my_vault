import 'package:dartz/dartz.dart';
import 'package:my_vault/features/savings/domain/entities/savings.dart';
import 'package:my_vault/features/savings/domain/repositories/savings_repository.dart';

import '../../core/error/failures.dart';

class GetSavings {
  final SavingsRepository repository;

  GetSavings(this.repository);

  Future<Either<Failure, List<Saving>>> call() async {
    return await repository.getSavings();
  }
}
