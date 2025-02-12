import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/savings.dart';
import '../../domain/repositories/savings_repository.dart';
import '../datasources/saving_local_datasource.dart';
import '../models/saving_model.dart';

class SavingsRepositoryImpl implements SavingsRepository {
  final SavingsLocalDataSource localDataSource;

  SavingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Saving>>> getSavings() async {
    try {
      final savingModels = localDataSource.getSavings();
      List<Saving> res = savingModels.map((e) => e.toEntity()).toList();
      return Right(res);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<void> addSaving(Saving saving) async {
    await localDataSource.addSaving(SavingModel.fromEntity(saving));
  }
}
