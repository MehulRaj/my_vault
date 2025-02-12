import 'package:my_vault/features/savings/domain/entities/component.dart';

import '../../domain/repositories/component_repository.dart';

class ComponentRepositoryImpl implements ComponentRepository {
  final ComponentRepository localDataSource;

  ComponentRepositoryImpl(this.localDataSource);

  @override
  Stream<Component?> watchTransactionData() {
    return localDataSource.watchTransactionData();
  }

  @override
  Component? getTransactionData() {
    return localDataSource.getTransactionData();
  }

  @override
  Future<void> updateTransactionData(Component transaction) {
    return localDataSource.updateTransactionData(transaction);
  }
}
