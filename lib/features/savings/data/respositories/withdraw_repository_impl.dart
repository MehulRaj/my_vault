import 'package:dartz/dartz.dart';
import 'package:my_vault/features/savings/data/datasources/withdraw_local_datasource.dart';
import 'package:my_vault/features/savings/data/models/withdraw_model.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';
import 'package:my_vault/features/savings/domain/repositories/withdraw_repository.dart';

import '../../core/error/failures.dart';

class WithdrawRepositoryImpl implements WithdrawRepository {
  final WithdrawsLocalDataSource localDataSource;

  WithdrawRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Withdraw>>> getWithdraws() async {
    try {
      final savingModels = localDataSource.getWithdraw();
      List<Withdraw> res = savingModels.map((e) => e.toEntity()).toList();
      return Right(res);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<void> addWithdraw(Withdraw saving) async {
    localDataSource.addSaving(WithdrawModel.fromEntity(saving));
  }
}
