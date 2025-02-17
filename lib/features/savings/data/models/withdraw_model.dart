import 'package:hive_flutter/hive_flutter.dart';

part 'withdraw_model.g.dart';

@HiveType(typeId: 1)
class WithdrawModel extends HiveObject {
  @HiveField(0, defaultValue: 0.0)
  final double amount;
  @HiveField(1, defaultValue: "")
  final String component;
  @HiveField(2)
  final DateTime? date; // Make it nullable


  WithdrawModel({
    required this.amount,
    required this.component,
    required this.date,
  });

  // Conversion from Entity to Model
  factory WithdrawModel.fromEntity(WithdrawModel trip) => WithdrawModel(
        amount: trip.amount,
        component: trip.component,
        date: trip.date,
      );

  // Conversion from Model to Entity
  WithdrawModel toEntity() => WithdrawModel(
        amount: amount,
        component: component,
        date: date,
      );
}
