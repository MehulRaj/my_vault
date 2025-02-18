import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_vault/features/savings/domain/usecases/update_component_data.dart';
import '../../core/constants.dart';
import '../../core/hive/hive_boxes.dart';
import '../../data/datasources/component_local_datasource.dart';
import '../../data/models/component_model.dart';
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

// Update Transaction Data Use Case Provider
final updateTransactionDataProvider = Provider<UpdateComponentData>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return UpdateComponentData(repository);
});

// Transaction Data Stream Provider (Listenable)
final transactionFutureProvider = FutureProvider<ComponentModel?>((ref) async {
  final box = HiveBoxes.transactionDataBox;
  final componentModel = box.get(Constant.component);

  print("⚡ FutureProvider fetched: $componentModel");

  return componentModel?.toEntity();
});

// Transaction Data Notifier Provider (For Updates)
final transactionNotifierProvider =
    StateNotifierProvider<ComponentNotifier, ComponentModel?>((ref) {
  final updateTransactionData = ref.watch(updateTransactionDataProvider);
  return ComponentNotifier(updateTransactionData);
});

// Notifier for Updating Transactions
class ComponentNotifier extends StateNotifier<ComponentModel?> {
  final UpdateComponentData _updateTransactionData;

  ComponentNotifier(this._updateTransactionData) : super(null);

  Future<void> update(ComponentModel transaction) async {
    try {
      await _updateTransactionData(transaction);
    } catch (e) {}
    state = transaction;
  }
}
