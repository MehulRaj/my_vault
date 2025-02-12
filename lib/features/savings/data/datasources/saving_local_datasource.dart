import 'package:hive_flutter/adapters.dart';

import '../models/saving_model.dart';

class SavingsLocalDataSource {
  final Box<SavingModel> tripBox;

  SavingsLocalDataSource(this.tripBox);

  List<SavingModel> getSavings() {
    return tripBox.values.toList();
  }

  Future<void> addSaving(SavingModel trip) async {
    await tripBox.add(trip);
  }
}
