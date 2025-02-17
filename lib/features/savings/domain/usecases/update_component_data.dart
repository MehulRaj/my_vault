import 'package:my_vault/features/savings/domain/repositories/component_repository.dart';

import '../../data/models/component_model.dart';

class UpdateComponentData {
  final ComponentRepository repository;

  UpdateComponentData(this.repository);

  Future call(ComponentModel transaction) async {
    return await repository.updateTransactionData(transaction);
  }
}