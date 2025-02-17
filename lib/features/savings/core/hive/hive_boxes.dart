import 'package:hive_flutter/adapters.dart';
import 'package:my_vault/features/savings/core/constants.dart';
import 'package:my_vault/features/savings/data/models/component_model.dart';
import 'package:my_vault/features/savings/data/models/savings_model.dart';
import 'package:my_vault/features/savings/data/models/withdraw_model.dart';

class HiveBoxes {
  static Future<void> init() async {
    Hive.registerAdapter(ComponentModelAdapter());
    Hive.registerAdapter(WithdrawModelAdapter());
    Hive.registerAdapter(SavingsModelAdapter());
    await Hive.openBox<ComponentModel>(Constant.component).then((value) => print("VALUE : ${value.toMap()}"),);
  }

  static Box<ComponentModel> get transactionDataBox =>
      Hive.box<ComponentModel>(Constant.component);
}
