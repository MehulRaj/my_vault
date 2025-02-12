import 'package:my_vault/features/savings/domain/entities/component.dart';
import 'package:my_vault/features/savings/domain/repositories/component_repository.dart';

class UpdateComponentData {
  final ComponentRepository repository;

  UpdateComponentData(this.repository);

  Future<void> call(Component transaction) {
    return repository.updateTransactionData(transaction);
  }
}