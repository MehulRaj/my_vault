import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/savings.dart';

abstract class SavingsRepository {
  Future<Either<Failure, List<Saving>>> getSavings();
  Future<void> addSaving(Saving trip);
}
