import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_vault/features/savings/domain/entities/component.dart';
import 'package:my_vault/features/savings/domain/repositories/component_repository.dart';
import 'package:my_vault/features/savings/domain/usecases/update_component_data.dart';

import '../../data/datasources/component_local_datasource.dart';
import '../../data/respositories/component_repository_impl.dart';

// Local Data Source Provider
final transactionLocalDataSourceProvider =
    Provider<ComponentLocalDatasource>((ref) {
  return ComponentLocalDatasource();
});

// Repository Provider
final transactionRepositoryProvider = Provider<ComponentRepositoryImpl>((ref) {
  final localDataSource = ref.watch(transactionLocalDataSourceProvider);
  return ComponentRepositoryImpl(localDataSource);
});

// Get Transaction Data Use Case Provider
final getTransactionDataProvider = Provider<ComponentRepository>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return ComponentRepositoryImpl(repository);
});

// Update Transaction Data Use Case Provider
final updateTransactionDataProvider = Provider<UpdateComponentData>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return UpdateComponentData(repository);
});

// Transaction Data Stream Provider (Listenable)
final transactionStreamProvider = StreamProvider<Component?>((ref) {
  final getTransactionData = ref.watch(getTransactionDataProvider);
  return getTransactionData.watchTransactionData();
});

// Transaction Data Notifier Provider (For Updates)
final transactionNotifierProvider =
    StateNotifierProvider<ComponentNotifier, Component?>((ref) {
  final updateTransactionData = ref.watch(updateTransactionDataProvider);
  final transaction = ref.watch(transactionStreamProvider).value;
  return ComponentNotifier(updateTransactionData, transaction);
});

// Notifier for Updating Transactions
class ComponentNotifier extends StateNotifier<Component?> {
  final UpdateComponentData _updateTransactionData;

  ComponentNotifier(this._updateTransactionData, Component? transaction)
      : super(transaction);

  Future<void> update(Component transaction) async {
    await _updateTransactionData(transaction);
    state = transaction;
  }
}
