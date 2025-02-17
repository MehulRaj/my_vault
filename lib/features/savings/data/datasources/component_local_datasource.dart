import 'package:hive_flutter/adapters.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/domain/repositories/component_repository.dart';

import '../../core/hive/hive_boxes.dart';
import '../models/component_model.dart';

class ComponentLocalDatasource implements ComponentRepository {
  final Box<ComponentModel> _box = HiveBoxes.transactionDataBox;

  @override
  Stream<ComponentModel?> watchTransactionData() {
    return _box.watch().map((_) => _box.get(Constant.component));
  }

  @override
  ComponentModel? getTransactionData() {
    final componentModel = _box.get(Constant.component);

    // Log fetched data
    print("🔄 Data fetched from Hive on restart: $componentModel");

    return componentModel?.toEntity();
  }

  @override
  Future<void> updateTransactionData(ComponentModel transaction) async {
    await _box.put(Constant.component, transaction);
    print("📌 Data saved in Hive: ${_box.get(Constant.component)}");
  }
}
