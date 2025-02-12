import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_vault/features/savings/domain/entities/withdraw.dart';


part 'withdraw_model.g.dart';

@HiveType(typeId: 1)
class WithdrawModel {
  @HiveField(0)
  final double amount;
  @HiveField(1)
  final String component;
  @HiveField(2)
  final DateTime date;

  WithdrawModel(
      {required this.amount, required this.component, required this.date});

  factory WithdrawModel.fromEntity(Withdraw trip) => WithdrawModel(
    amount: trip.amount,
    component: trip.component,
    date: trip.date
  );

  // Conversion from Model to Entity
  Withdraw toEntity() =>
      Withdraw(amount: amount, component: component, date: date);
}
