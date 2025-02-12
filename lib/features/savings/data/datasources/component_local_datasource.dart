import 'package:hive_flutter/adapters.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/domain/repositories/component_repository.dart';

import '../../core/hive/hive_boxes.dart';
import '../../domain/entities/component.dart';

class ComponentLocalDatasource implements ComponentRepository {
  final Box<Component> _box = HiveBoxes.transactionDataBox;

  @override
  Stream<Component?> watchTransactionData() {
    return _box.watch().map((_) => _box.get(Constant.component));
  }

  @override
  Component? getTransactionData() {
    return _box.get(Constant.component);
  }

  @override
  Future<void> updateTransactionData(Component transaction) async {
    await _box.put(Constant.component, transaction);
  }
}
