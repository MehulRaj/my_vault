import 'package:hive_flutter/adapters.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/data/models/component_model.dart';
import 'package:my_vault/features/savings/data/models/saving_model.dart';
import 'package:my_vault/features/savings/data/models/withdraw_model.dart';
import 'package:my_vault/features/savings/domain/entities/component.dart';

class HiveBoxes {
  static Future<void> init() async {
    Hive.registerAdapter(ComponentModelAdapter());
    Hive.registerAdapter(SavingModelAdapter());
    Hive.registerAdapter(WithdrawModelAdapter());
    await Hive.openBox<Component>(Constant.component);
  }

  static Box<Component> get transactionDataBox =>
      Hive.box<Component>(Constant.component);
}
