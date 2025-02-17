import '../../domain/repositories/component_repository.dart';
import '../models/component_model.dart';

class ComponentRepositoryImpl implements ComponentRepository {
  final ComponentRepository localDataSource;

  ComponentRepositoryImpl(this.localDataSource);

  @override
  Stream<ComponentModel?> watchTransactionData() {
    return localDataSource.watchTransactionData();
  }

  @override
  ComponentModel? getTransactionData() {
    print("getTransactionData");
    print(localDataSource.getTransactionData());
    return localDataSource.getTransactionData();
  }

  @override
  Future<void> updateTransactionData(ComponentModel transaction) {
    print("updateTransactionData : ");
    return localDataSource.updateTransactionData(transaction);
  }
}
