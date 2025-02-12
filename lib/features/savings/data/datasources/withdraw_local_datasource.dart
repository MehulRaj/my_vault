import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_vault/features/savings/data/models/withdraw_model.dart';

class WithdrawsLocalDataSource {
  final Box<WithdrawModel> tripBox;

  WithdrawsLocalDataSource(this.tripBox);

  List<WithdrawModel> getWithdraw() {
    return tripBox.values.toList();
  }

  void addSaving(WithdrawModel trip) {
    tripBox.add(trip);
  }
}
