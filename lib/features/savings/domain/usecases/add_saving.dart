import 'package:my_vault/features/savings/domain/entities/savings.dart';
import 'package:my_vault/features/savings/domain/repositories/savings_repository.dart';

class AddSaving {
  final SavingsRepository repository;

  AddSaving(this.repository);

  Future<void> call(Saving trip) {
    return repository.addSaving(trip);
  }
}
